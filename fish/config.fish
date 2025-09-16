# Homebrew - comes first to update env
if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Override `$EDIT` in each editor in order to use itself
    if not set -q EDIT
        set -x EDIT zed
    end

    set -x EDITOR "$EDIT --wait"

    # fzf: https://junegunn.github.io/fzf/shell-integration/
    if command -q fzf
        fzf --fish | source
    end

    # direnv
    if command -q direnv
        direnv hook fish | source
    end

    # zoxide: https://github.com/ajeetdsouza/zoxide
    if command -q zoxide
        zoxide init fish | source
    end

    # k8s
    if command -q kubectl
        kubectl completion fish | source
    end

    if command -q ngrok
        ngrok completion | source
    end

    # Prompt
    set -g lucid_prompt_symbol_error "!"
end

# Be verbose
abbr mv 'mv -v'
abbr rm 'rm -v'
abbr cp 'cp -v'

# fish
abbr conf "$EDIT ~/.config/fish/config.fish"
abbr fconf "$EDIT ~/.config/fish"

# JJ
abbr j jj
abbr ji jjui
abbr js jj status
abbr jsp jj split
abbr ju jj undo
abbr jn  jj new
abbr jna jj new --no-edit --after
abbr jnb jj new --no-edit --before
abbr jd --set-cursor "jj diff --ignore-space-change -r @%"
abbr jc --set-cursor "jj commit --message '%'"
abbr jl  jj log
abbr jll jj log --limit 8
abbr jls jj log --summary
abbr jlt "jj log -r 'trunk()::@'"
abbr je jj edit
abbr ja jj absorb
abbr jab jj abandon
abbr jsh --set-cursor "jj show -r @%"
abbr jb  jj bookmark
abbr jbc jj bookmark create
abbr jbm jj bookmark move
abbr jbt jj bookmark track
abbr jbf jj bookmark forget
abbr jtug "jj bookmark move --from 'closest_bookmark(@-)' --to '@-'"
abbr jr jj rebase
abbr jjmerge jj resolve --tool mergiraf
abbr jg jj git
abbr jgp jj git push
abbr jgf jj git fetch # TODO: remove when used to `jf`
abbr jgc jj git clone --colocate
abbr jf jj git fetch
abbr jw jj workspace
abbr jwu jj workspace update-stale
abbr jsq jj squash
abbr jsqi jj squash --into

# `jsq` behaves like `jm` but for `jj squash`. Examples:
# `jsqol`  -> `jj squash --into ol`
# `jsq-`   -> `jj squash --into @-`
abbr jj_squash_into_rev --regex "jsq.*" --function _jj_squash_abbr
abbr zsq "jj diff --name-only | fzf --multi --preview 'jj diff --color always --git {1}' --keep-right | xargs jj squash"


# `jm` becomes   jj describe -r @ -m ""
# `jm-` becomes  jj describe -r @- -m ""
# `jm--` becomes jj describe -r @-- -m ""
# `jmxy` becomes jj describe -r xy -m ""
function _jj_describe_abbr
    set -f rev (string sub --start 3 $argv[1])

    if test -n (string match --regex "^[-+]*\$" -- $rev || echo "")
        set -f rev "@$rev"
    end

    if test -z $rev
        set -f rev "@-"
    end

    echo "jj describe -r $rev -m '%'"
end
abbr jj_describe_rev --regex "jm.*" --set-cursor --function _jj_describe_abbr
abbr jj_describe_rev_no_msg --regex "jds.*" --function _jj_describe_abbr_no_msg

abbr jj_git --command jj --regex g -- git
abbr jj_msg --command jj --regex -m --set-cursor -- "--message '%'"
abbr jj_no_edit --command jj --regex -ne -- --no-edit
abbr jj_limit --command jj --regex -l -- "--limit 5"
abbr jj_no_whitespace --command jj --regex -w -- --ignore-all-space

abbr mn "jj git fetch && jj rebase -d main"
abbr ma "jj git fetch && jj rebase -d master"

# Expands `^` to the last argument of the most recent command
# e.g.
# $ ls path/to/x
# ...
# $ cd ^  ==>  cd path/to/x
function _last_arg_of_most_recent_command
    echo $history[1] | string split ' ' | tail -n 1
end
abbr --position anywhere ^ --function _last_arg_of_most_recent_command

# git
abbr g git

abbr ga git add
abbr gai git add --interactive

abbr gc git commit
abbr gca git commit --amend
abbr gcs git commit --squash
abbr gcf git commit --fixup

abbr gb git branch
abbr gbc "git branch --show-current | string collect | pbcopy"

abbr gbl git blame

abbr gd git diff
abbr gdc git diff --cached

abbr gf git fetch
abbr gfm git fetch origin main:main

abbr gl git log

abbr gt git tag

abbr gs git status -sb

abbr gst git stash
abbr pop git stash pop
abbr gsp git stash pop
abbr gsa "git add . && git stash"

abbr gm git merge --autostash
abbr gma git merge --abort
abbr gmm git merge --autostash main
abbr ff git merge --autostash --ff-only
abbr ffm git merge --autostash --ff-only main

abbr gpl git pull --autostash

abbr gr git rebase --autostash
abbr gro git rebase --autostash --onto main
abbr grm git rebase --autostash main
abbr gri git rebase --interactive --autosquash
abbr grc git rebase --continue

abbr grs git restore
abbr grss git restore --staged

abbr undo git reset HEAD~1
abbr grst git reset HEAD~1

abbr grv git revert

abbr gw git worktree
abbr gwl git worktree list

abbr gcp git cherry-pick

abbr gco git checkout

abbr gsw "git branch | fzf --preview 'git log --color=always {-1}' --bind 'enter:become(git switch {-1})'"

# Replaced with jj equivalent above ^
# abbr mn "git switch main && git pull --autostash"


# kubectl
abbr k   kubectl
abbr kci kubectl cluster-info
abbr kg  kubectl get
abbr kgp kubectl get pods
abbr kd  kubectl describe
abbr kl  kubectl logs

# cd
abbr cdr "cd (jj root)"

# fd
# https://github.com/sharkdp/fd
abbr f fd --no-require-git
abbr ft "fd --no-require-git | tree --fromfile"

# ls + eza
abbr l eza
abbr l1 eza --all -1
abbr ll eza --all --long
abbr lh eza --all --long --total-size

# Rust
abbr c cargo
abbr ca cargo add
abbr cad cargo add --dev
abbr cb cargo build
abbr cr cargo run
abbr ct cargo test
abbr cir cargo insta review
abbr cit cargo insta test --unreferenced delete

# docker
abbr d docker
abbr dr docker run
abbr db docker buildx

# npm
abbr n npm
abbr nr npm run
abbr ni npm install

# yarn
abbr y yarn
abbr ya yarn add
abbr yad yarn add --dev
abbr yw yarn workspace

# pnpm
abbr p pnpm
abbr pr pnpm run
abbr pe pnpm exec
abbr pi pnpm install

# brew
abbr b brew

# make
abbr m make

# Next.js
set -gx NEXT_TELEMETRY_DISABLED 1
# Turbo
set -gx TURBO_TELEMETRY_DISABLED 1

# Claude code
set -gx DISABLE_TELEMETRY 1

# Hurl
abbr h hurl

# Zed
abbr ze zed

# Cursor
abbr cu cursor

# Aider
abbr a aider
abbr awd "aider (jj diff --name-only)" # Start aider with edited files loaded
# abbr awd "aider (git status -s | awk '{print \$NF}')" # Start aider with edited files loaded
abbr aw aider --watch-files
abbr aider_read --command aider --regex r -- --read
abbr aider_edit --command aider --regex e -- --edit
abbr aider_msg_ --command aider --regex m -- --message
abbr aider_msgf --command aider --regex mf -- --message-file
abbr aider_test --command aider --regex t -- --test
abbr aider_wtch --command aider --regex w -- --watch-files

set -x AIDER_NOTIFICATIONS true

# aider-script
abbr as aider-script

# auto_describe function
abbr at auto_describe

# Projects
abbr morn "jj git fetch && jj rebase -d master && make build && make migrate && zellij --layout ~/work/monorepo/sam-tools/humaans.kdl"

# iOS simulator
# Open url in already booted simulator
abbr so "xcrun simctl openurl booted (pbpaste)"

# Android simulator
abbr andr_paste adb shell input text

# Xcode
abbr xcderiv cd ~/Library/Developer/Xcode/DerivedData

# Project specific
abbr ava "pnpm --dir app/server exec ava"
abbr ch "./scripts/check.sh"

# Add Google Cloud SDK to PATH
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]
    . "$HOME/google-cloud-sdk/path.fish.inc"
end

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/sam/.opam/opam-init/init.fish' && source '/Users/sam/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration

# Difftastic
set -x DFT_PARSE_ERROR_LIMIT 20
