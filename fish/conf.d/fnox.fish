if type -q chainenv
    set -l age_key (chainenv get FNOX_AGE_KEY)
    if test -n "$age_key"
        set -gx FNOX_AGE_KEY $age_key
    end
end

if type -q fnox
    #fnox activate fish --no-hook-env | source
    fnox activate fish | source
end

# Caches the project's 1Password secrets in fnox.local.toml. Projects name the
# 1Password provider either `op` or `1password`; `fnox sync --source` accepts
# only one name, so sync each one that some secret uses. Checking the secrets
# instead of `fnox provider list` matters because parent configs such as
# ~/fnox.toml can define a provider no secret here refers to. `-y` skips the
# confirmation prompt; other arguments pass through to `fnox sync`.
#
# Without -P it syncs the default profile and every `[profiles.<name>]` in the
# project's fnox.toml. Each profile caches into its own section of
# fnox.local.toml, and a profile without its own cached entry would read the
# default profile's cached value instead of its fnox.toml reference.
function fsync --description 'Cache 1Password secrets in fnox.local.toml'
    argparse --ignore-unknown y/yes P/profile= -- $argv; or return
    if set -q _flag_yes
        set -p argv --force
    end

    set -l profiles $_flag_profile
    if test -z "$profiles"
        set profiles default
        for config in fnox.toml .fnox.toml
            test -f $config; and set -a profiles (string match -rg '^\[profiles\.([^.\]]+)' <$config)
        end
        set profiles (printf '%s\n' $profiles | awk '!seen[$0]++')
    end

    set -l synced 0
    for profile in $profiles
        set -l secrets (fnox -P $profile list 2>/dev/null)
        for src in op 1password
            if string match -q -- "*provider ($src)*" $secrets
                echo "fsync: $profile ($src)" >&2
                fnox -P $profile sync --provider age --local-file --source $src $argv; or return
                set synced 1
            end
        end
    end
    if test $synced -eq 0
        echo 'fsync: no secrets use an `op` or `1password` provider' >&2
        return 1
    end
end
