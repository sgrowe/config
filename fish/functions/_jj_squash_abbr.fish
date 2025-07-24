function _jj_squash_abbr
    set -f fish_trace 1

    set -f rev (string sub --start 4 $argv[1])

    if test -n (string match --regex "^[-+]*\$" -- $rev || echo "")
        set -f rev "@$rev"
    end

    if test -z $rev
        echo "jj squash"
        return
    end

    echo "jj squash --into $rev"
end
