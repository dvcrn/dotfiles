function fnox-cloud --description "Run fnox against fnox.cloud.toml, encrypting to the cloud-agent age key"
    set -l recipient age1j84a8smt77mpcqphyhfjz0g9gw0gehzad4yuvcerr856hw87gyvsq2hp0q

    # fnox loads fnox.<profile>.toml only under `-P <profile>`. The provider is
    # named `cloud` so the global [providers.age] (local key) can never shadow it.
    # `-P cloud` also pulls in fnox.toml's top-level secrets, which the cloud key
    # cannot decrypt; the top-level if_missing = "ignore" silences those, while
    # each cloud secret gets its own if_missing = "error" so real failures surface.

    set -l is_write 0
    contains -- "$argv[1]" set s remove rm delete import im; and set is_write 1

    set -l file (__fnox_cloud_find)
    if test -n "$file"
        # fnox write commands target the current directory, so running them from a
        # subdirectory would create a stray fnox.toml there.
        if test $is_write -eq 1; and test (path dirname $file) != (path resolve $PWD)
            echo "fnox-cloud: run write commands from "(path dirname $file) >&2
            return 1
        end
        __fnox_cloud_fix_file $file $recipient
        or return
    else if test $is_write -eq 1
        set -l git_root (command git rev-parse --show-toplevel 2>/dev/null)
        if not test -e fnox.toml; and test "$git_root" != (path resolve $PWD)
            echo "fnox-cloud: no fnox.cloud.toml found; run from the project root (next to fnox.toml or at the git root)" >&2
            return 1
        end
        set file $PWD/fnox.cloud.toml
        printf 'if_missing = "ignore"\n\n[providers.cloud]\ntype = "age"\nrecipients = ["%s"]\n' $recipient >$file
        echo "fnox-cloud: created $file" >&2
    end

    set -l key
    if contains -- "$argv[1]" set s
        # Any other provider resolves through the global config to the local key.
        set -l provider (__fnox_cloud_provider $argv[2..-1])
        if test -n "$provider"; and test "$provider" != cloud
            echo "fnox-cloud: refusing --provider $provider; secrets in fnox.cloud.toml must use the cloud provider (omit -p)" >&2
            return 1
        end
        set -l extra
        test -n "$provider"
        or set -a extra --provider cloud
        string match -q -r -- '^--if-missing(=.*)?$' $argv[2..-1]
        or set -a extra --if-missing error
        set key (__fnox_cloud_set_key $argv[2..-1])
        set argv $argv[1] $extra $argv[2..-1]
    end

    fnox -P cloud $argv
    or return

    if test -n "$key"; and not __fnox_cloud_uses_cloud $file $key
        echo "fnox-cloud: warning, $key in $file is not using the cloud provider" >&2
        return 1
    end
end

function __fnox_cloud_find
    # Nearest fnox.cloud.toml in the current directory or its parents.
    set -l dir (path resolve $PWD)
    while true
        if test -e $dir/fnox.cloud.toml
            echo $dir/fnox.cloud.toml
            return 0
        end
        test "$dir" = /; and return 1
        set dir (path dirname $dir)
    end
end

function __fnox_cloud_set_key
    # Returns the KEY positional of `fnox set`, skipping flags and their values.
    set -l takes_value -d --description -p --provider -k --key-name --default --from-file --if-missing -c --config -P --profile --write-profile
    set -l skip 0
    set -l after_dashes 0
    for arg in $argv
        if test $skip -eq 1
            set skip 0
        else if test $after_dashes -eq 0; and test "$arg" = --
            set after_dashes 1
        else if test $after_dashes -eq 0; and contains -- $arg $takes_value
            set skip 1
        else if test $after_dashes -eq 0; and string match -q -- '-*' $arg
            continue
        else
            echo $arg
            return 0
        end
    end
    return 1
end

function __fnox_cloud_provider
    # Prints the value of -p/--provider from `fnox set` arguments, if any.
    set -l next 0
    for arg in $argv
        test "$arg" = --; and return 1
        if test $next -eq 1
            echo $arg
            return 0
        end
        switch $arg
            case -p --provider
                set next 1
            case '--provider=*'
                string replace -- --provider= '' $arg
                return 0
            case '-p*'
                string sub -s 3 -- $arg
                return 0
        end
    end
    return 1
end

function __fnox_cloud_section --argument-names name
    # Prints the body of the [<name>] table from stdin. Headers may carry
    # trailing whitespace or a comment.
    awk -v name="$name" '
        function is_header(line) { return line ~ /^[ \t]*\[[^\]]+\][ \t]*(#.*)?$/ }
        function header_name(line) { sub(/^[ \t]*\[/, "", line); sub(/\].*$/, "", line); gsub(/[ \t"]/, "", line); return line }
        is_header($0) { inside = (header_name($0) == name); next }
        inside { print }
    '
end

function __fnox_cloud_first_line --argument-names regex
    # 1-based index of the first argument after the regex that matches it.
    set -l i 0
    for line in $argv[2..-1]
        set i (math $i + 1)
        if string match -q -r -- $regex $line
            echo $i
            return 0
        end
    end
    return 1
end

function __fnox_cloud_has_table --argument-names name
    string match -q -r -- '^\s*\[\s*'(string escape --style=regex -- $name)'\s*\]\s*(#.*)?$' $argv[2..-1]
end

function __fnox_cloud_uses_cloud --argument-names file key
    set -l key_re (string escape --style=regex -- $key)
    string match -q -r -- "^\s*\"?$key_re\"?\s*=.*provider\s*=\s*\"cloud\"" <$file
    and return 0
    __fnox_cloud_section secrets.$key <$file | string match -q -r -- '^\s*provider\s*=\s*"cloud"'
end

function __fnox_cloud_fix_file --argument-names file recipient
    set -l lines (cat $file)
    set -l changed

    if __fnox_cloud_has_table providers.cloud $lines
        if not printf '%s\n' $lines | __fnox_cloud_section providers.cloud | string match -q -- "*$recipient*"
            echo "fnox-cloud: [providers.cloud] in $file does not use the cloud recipient $recipient" >&2
            return 1
        end
    else if __fnox_cloud_has_table providers.age $lines; and printf '%s\n' $lines | __fnox_cloud_section providers.age | string match -q -- "*$recipient*"
        # Legacy layout: [providers.age] already pointed at the cloud key, so its
        # secrets are cloud ciphertext and can be relabeled without re-encrypting.
        set lines (string replace -r -- '^(\s*)\[\s*providers\.age\s*\]' '$1[providers.cloud]' $lines)
        set lines (string replace -r -- '^(default_provider\s*=\s*)"age"' '$1"cloud"' $lines)
        set lines (string replace -r -a -- '(\bprovider\s*=\s*)"age"' '$1"cloud"' $lines)
        set -a changed "renamed [providers.age] to [providers.cloud]"
    else
        set -l block '[providers.cloud]' 'type = "age"' "recipients = [\"$recipient\"]" ''
        set -l index (__fnox_cloud_first_line '^\s*\[\s*secrets\s*[\].]' $lines)
        if test -z "$index"
            set -a lines '' $block[1..3]
        else if test $index -eq 1
            set lines $block $lines
        else
            set lines $lines[1..(math $index - 1)] $block $lines[$index..-1]
        end
        set -a changed "added [providers.cloud]"
    end

    # Top-level keys must come before the first [table] header, and only those
    # count; a secret's own if_missing inside [secrets.X] is not top-level.
    set -l first_table (__fnox_cloud_first_line '^\s*\[' $lines)
    set -l top $lines
    test -n "$first_table"; and test $first_table -gt 1; and set top $lines[1..(math $first_table - 1)]
    test "$first_table" = 1; and set top
    if not string match -q -r -- '^\s*if_missing\s*=' $top
        if test -z "$first_table"
            set -a lines 'if_missing = "ignore"'
        else if test $first_table -eq 1
            set lines 'if_missing = "ignore"' '' $lines
        else
            set lines $lines[1..(math $first_table - 1)] 'if_missing = "ignore"' '' $lines[$first_table..-1]
        end
        set -a changed 'added top-level if_missing = "ignore"'
    end

    if set -q changed[1]
        printf '%s\n' $lines >$file
        for msg in $changed
            echo "fnox-cloud: $msg in $file" >&2
        end
    end
end
