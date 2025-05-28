function hot
    set -l fish_trace 1

    fswatch -0 "$argv[1]" | while read -d "" --null file
        if string match -q "*.bs.js" "$file"
            echo "// 🔥" >> "$file"
        end
    end
end
