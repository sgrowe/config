function _jj_squash_abbr
    set -f rev (string sub --start 4 $argv[1])

    # Change IDs use k-z range, or @/-/+ for relative change IDs
    # If revision contains only - and +, it's a relative change ID, prepend @
    if test -n (string match --regex "^[-+]+\$" -- $rev || echo "")
        set -f rev "@$rev"
    end

    if test -z $rev
        echo "jj squash"
        return
    end

    echo "jj squash --into $rev"
end
