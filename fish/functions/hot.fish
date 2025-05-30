function hot
    set -f str "console.debug('🔥')"

    fswatch -0 "$argv[1]" | while read -d "" --null file
        if string match -q "*.bs.js" "$file" && ! rg --fixed-strings --line-regexp --quiet "$str" "$file"
            echo "$file"
            sleep 1
            echo "$str" >> "$file"
        end
    end
end
