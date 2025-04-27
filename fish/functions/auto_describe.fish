function auto_describe
    # Use revision given in first argument, or default to `@`
    set -f rev $argv[1]
    if test -z "$rev"
        set -f rev "@"
    end

    # Get the full change ID in case it changes. e.g. working commit `@` moves
    set -f change_id "$(jj log --no-graph -T 'change_id' --revisions $rev)"

    echo "Change ID: $change_id"

    set -f diff "$(jj diff --ignore-space-change -r $change_id | cat)"

    set -f desc "$(llm -s "Provide a concise, one line commit message for this diff. Be specific. Respond with the commit message only." "$diff")"

    echo "Description: $desc"
    echo

    set -l fish_trace 1

    jj describe -r "$change_id" -m "$desc"
end
