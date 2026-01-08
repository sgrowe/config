function wt --argument-names subcommand branch_name
    if test "$subcommand" != "new"
        echo "Usage: wt new <branch-name>"
        return 1
    end

    if test -z "$branch_name"
        echo "Usage: wt new <branch-name>"
        return 1
    end

    set -l project_name (basename (pwd))
    set -l main_worktree_path (pwd)
    set -l workspace_path ../$project_name.$branch_name

    set -l revset main
    if set -q DEFAULT_WORKSPACE_REVSET; and test -n "$DEFAULT_WORKSPACE_REVSET"
        set revset $DEFAULT_WORKSPACE_REVSET
    end
    jj workspace add $workspace_path --revision $revset
    and cd $workspace_path
    and if test -f ./post-clone.fish
        env MAIN_WORKTREE_PATH=$main_worktree_path ./post-clone.fish
    end
end
