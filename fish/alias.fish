#
# Aliases
#
abbr vim nvim
abbr vi nvim
abbr kssh kitten ssh

# Git
abbr g git

abbr k kubectl
abbr kctx kubectl config use-context

# Branch (b)
abbr gb "git branch"
abbr gbc "git checkout -b"
abbr gbl "git branch -v"
abbr gbL "git branch -av"
abbr gbx "git branch -d"
abbr gbX "git branch -D"
abbr gbm "git branch -m"
abbr gbM "git branch -M"
abbr gbs "git show-branch"
abbr gbS "git show-branch -a"
abbr gbcp "git branch | grep '*' | sed s/\*\ // | tr -d '\n\r' | pbcopy"

abbr gc "git commit --verbose"
abbr gca "git commit --verbose --all"
abbr gcm "git commit --message"
abbr gco "git checkout"
abbr gcO "git checkout --patch"
abbr gcp "git cherry-pick --ff"
abbr gcP "git cherry-pick --no-commit"
abbr gcr "git revert"
abbr gcR "git reset 'HEAD^'"
abbr gcs "git show"
abbr gcl "git-commit-lost"
abbr gsv "git show HEAD --pretty=fuller --show-signature"

abbr gcf "git commit --amend --reuse-message HEAD"
abbr gcF "git commit --verbose --amend"
abbr gcaF "git commit --all --amend"
abbr gcaf "git commit --all --amend --no-edit"


# Conflict (C)
abbr gCl "git status | sed -n 's/^.*both [a-z]*ed: *//p'"
abbr gCa "git add (gCl)"
abbr gCe "git mergetool (gCl)"
abbr gCo "git checkout --ours --"
abbr gCO "gCo (gCl)"
abbr gCt "git checkout --theirs --"
abbr gCT "gCt (gCl)"

# Data (d)
abbr gd "git ls-files"
abbr gdc "git ls-files --cached"
abbr gdx "git ls-files --deleted"
abbr gdm "git ls-files --modified"
abbr gdu "git ls-files --other --exclude-standard"
abbr gdk "git ls-files --killed"
abbr gdi "git status --porcelain --short --ignored | sed -n 's/^!! //p'"

# Fetch (f)
abbr gf "git fetch"
abbr gfc "git clone"
abbr gfm "git pull"
abbr gfr "git pull --rebase"

# Grep (g)
abbr gg "git grep"
abbr ggi "git grep --ignore-case"
abbr ggl "git grep --files-with-matches"
abbr ggL "git grep --files-without-matches"
abbr ggv "git grep --invert-match"
abbr ggw "git grep --word-regexp"

# Index (i)
abbr gia "git add"
abbr gii "git add --interactive"
abbr giA "git add --patch"
abbr giu "git add --update"
abbr gid "git diff --no-ext-diff --cached"
abbr giD "git diff --no-ext-diff --cached --word-diff"
abbr gir "git reset"
abbr giR "git reset --patch"
abbr gix "git rm -r --cached"
abbr giX "git rm -rf --cached"

# Log (l)
abbr gl "git log --topo-order --pretty=oneline --decorate=short"
abbr gls "git log --topo-order --stat --pretty=oneline --decorate=short"
abbr gld "git log --topo-order --stat --patch --short-diff --pretty=oneline --decorate=short"
abbr glo "git log --topo-order --pretty=oneline --decorate=short"
abbr glg "git log --topo-order --all --graph --pretty=oneline --decorate=short"
abbr glb "git log --topo-order --pretty=oneline --decorate=short"
abbr glc "git shortlog --summary --numbered"

# Merge (m)
abbr gm "git merge"
abbr gmC "git merge --no-commit"
abbr gmF "git merge --no-ff"
abbr gma "git merge --abort"
abbr gmt "git mergetool"

# Push (p)
abbr gp "git push"
abbr gpf "git push --force"
abbr gpa "git push --all"
abbr gpA "git push --all; and git push --tags"
abbr gpt "git push --tags"

function gpc
  set branch (git rev-parse --abbrev-ref HEAD)
  git push -u origin $branch
end

function gpp
  set branch (git rev-parse --abbrev-ref HEAD)
  git pull origin $branch; git push origin $branch
end

# Rebase (r)
abbr gr "git rebase"
abbr gra "git rebase --abort"
abbr grc "git rebase --continue"
abbr gri "git rebase --interactive"
abbr grs "git rebase --skip"

# Remote (R)
abbr gR "git remote"
abbr gRl "git remote --verbose"
abbr gRa "git remote add"
abbr gRx "git remote rm"
abbr gRm "git remote rename"
abbr gRu "git remote update"
abbr gRp "git remote prune"
abbr gRs "git remote show"
abbr gRb "git-hub-browse"

# Stash (s)
abbr gs "git stash"
abbr gsa "git stash apply"
abbr gsx "git stash drop"
abbr gsX "git-stash-clear-interactive"
abbr gsl "git stash list"
abbr gsL "git-stash-dropped"
abbr gsd "git stash show --patch --stat"
abbr gsp "git stash pop"
abbr gsr "git-stash-recover"
abbr gss "git stash save --include-untracked"
abbr gsS "git stash save --patch --no-keep-index"
abbr gsw "git stash save --include-untracked --keep-index"

# Submodule (S)
abbr gS "git submodule"
abbr gSa "git submodule add"
abbr gSf "git submodule foreach"
abbr gSi "git submodule init"
abbr gSI "git submodule update --init --recursive"
abbr gSl "git submodule status"
abbr gSm "git-submodule-move"
abbr gSs "git submodule sync"
abbr gSu "git submodule foreach git pull origin master"
abbr gSx "git-submodule-remove"

# Working Copy (w)
abbr gws "git status --ignore-submodules=all --short"
abbr gwS "git status --ignore-submodules=all"
abbr gwd "git diff --no-ext-diff"
abbr gwD "git diff --no-ext-diff --word-diff"
abbr gwr "git reset --soft"
abbr gwR "git reset --hard"
abbr gwc "git clean -n"
abbr gwC "git clean -f"
abbr gwx "git rm -r"
abbr gwX "git rm -rf"

abbr ff "git pull --ff-only"

# network stuff
abbr wifi sudo networksetup -setairportpower "Wi-Fi"
abbr wifion sudo networksetup -setairportpower "Wi-Fi" on
abbr wifioff sudo networksetup -setairportpower "Wi-Fi" off
abbr renewlease sudo ipconfig set en0 DHCP
abbr useip sudo networksetup -setmanualwithdhcprouter Wi-Fi
abbr usedhcp sudo networksetup -setdhcp Wi-Fi
abbr ifaddr ipconfig getifaddr en0
abbr wifiinfo networksetup -getinfo Wi-Fi

function tryspoof
    if test (count $argv) -lt 2
        echo "Usage: tryspoof <MAC_ADDRESS> <IP_ADDRESS>"
        return 1
    end

    set m $argv[1]
    set ip $argv[2]
    echo "spoofing mac to $m, ip = $ip"

    sudo networksetup -setairportpower "Wi-Fi" off; or echo "Failed to turn off Wi-Fi, but continuing..."

    sudo /usr/local/bin/spoof set "$m" "en0"; or echo "Failed to spoof MAC address, but continuing..."

    echo "setting IP to $ip"
    sudo networksetup -setmanualwithdhcprouter "Wi-Fi" "$ip"; or echo "Failed to set IP address, but continuing..."

    sudo networksetup -setairportpower "Wi-Fi" on; or echo "Failed to turn on Wi-Fi, but continuing..."
end

# # Function shortcuts
# gcac() {
#   echo "Author -> Commiter"

#   git filter-branch -f --env-filter '
#     export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
#     export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
#     '  HEAD^..HEAD

#   git show HEAD --pretty=fuller
# }

# gcca() {
#   echo "Commiter -> Author"

#   git filter-branch -f --env-filter '
#     export GIT_AUTHOR_EMAIL="$GIT_COMMITTER_EMAIL"
#     export GIT_AUTHOR_NAME="$GIT_COMMITTER_NAME"
#     '  HEAD^..HEAD

#   git show HEAD --pretty=fuller
# }

# wip() {
#   git commit -am "wip $(date)"
# }

alias tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale
