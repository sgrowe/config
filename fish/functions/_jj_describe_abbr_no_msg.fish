function _jj_describe_abbr_no_msg
    set -f rev (string sub --start 4 $argv[1])

    if test -n (string match --regex "^[-+]*\$" -- $rev || echo "")
        set -f rev "@$rev"
    end

    if test -z $rev
        set -f rev "@"
    end

    echo "jj describe -r $rev"
end
