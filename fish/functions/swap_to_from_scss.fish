function swap_to_from_scss
    if string match -q -r '\\.scss$' "$ZED_FILE"
        set -f base (string replace -r '\\.scss$' '' "$ZED_FILE")
        if test -f "$base.res"
            set -f target_file "$base.res"
        else if test -f "$base.tsx"
            set -f target_file "$base.tsx"
        else if test -f "$base.jsx"
            set -f target_file "$base.jsx"
        else
            set -f target_file "$base.res"
        end
    else
        set -f target_file (string replace -r '\\.\\w+$' '.scss' "$ZED_FILE")
    end

    if test -n "$ZED_SELECTED_TEXT"
        set -f lineno (rg "$ZED_SELECTED_TEXT" $target_file --line-number --max-count=1 | awk '{split($0, a, ":"); print a[1]}')
    end

    if test -n "$lineno"
        zed "$target_file:$lineno"
    else
        zed "$target_file"
    end
end
