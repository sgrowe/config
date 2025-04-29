function watch
    while true;
        clear
        printf "watch: %s\n\n" "$argv"
        $argv
        sleep 2
    end
end