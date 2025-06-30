function auto_describe
    # set -f qwen mlx-community/Qwen3-0.6B-8bit
    set -f qwen mlx-community/Qwen3-1.7B-4bit
    set -f mistral mistralai/Mistral-Small-3.2-24B-Instruct-2506

    # Use revision given in first argument, or default to `@`
    set -f rev $argv[1]
    if test -z "$rev"
        set -f rev "@-"
    end

    echo "Revision: $rev"

    # Get the full change ID in case it changes. e.g. working commit `@` moves
    set -f change_id "$(jj log --no-graph -T 'change_id' --revisions $rev)"

    echo "Change ID: $change_id"

    set -f diff "$(jj diff --ignore-space-change --git -r $change_id | string collect)"

    set -f desc "$(mlx_lm.generate --verbose false --model $qwen --max-tokens 100000 --system-prompt "Provide a concise, one line commit message for this diff. Be specific. Respond with the commit message only." --prompt "$diff")"

    printf "\n\n%s\n\n" "$desc"

    set -f desc (string replace -r '<think>[\s\S]+?</think>\s*' '' "$desc" | string trim)

    set -l fish_trace 1

    jj describe -r "$change_id" -m "$desc" --edit
end
