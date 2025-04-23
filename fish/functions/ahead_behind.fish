function ahead_behind --description "Show git commits ahead and behind main branch"

    set -l branch (git branch --show-current)
    set -l branches "$branch...origin/main"

    echo ""
    echo "Comparing $branches"
    echo ""

    git fetch

    echo "Ahead   Behind"
    git rev-list --left-right --count $branches
    echo ""
end
