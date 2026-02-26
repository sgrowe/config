function flash_message --description 'Save or clear fish flash messages'
    set -l flash_messages_dir ~/.config/fish/flash_messages
    if set -q FLASH_MESSAGES_DIR
        set flash_messages_dir $FLASH_MESSAGES_DIR
    end

    if test "$argv[1]" = "--clear" -o "$argv[1]" = "—clear"
        mkdir -p $flash_messages_dir
        for file in $flash_messages_dir/*
            if test -f $file
                rm -f $file
            end
        end
        return 0
    end

    if test (count $argv) -eq 0
        echo "Usage: flash_message <message> | --clear" >&2
        return 1
    end

    mkdir -p $flash_messages_dir
    set -l file_name (date '+%Y%m%d%H%M%S')"_"(random)".txt"
    string join ' ' -- $argv >$flash_messages_dir/$file_name
end
