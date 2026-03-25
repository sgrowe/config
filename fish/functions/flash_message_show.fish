function flash_message_show --description 'Show all saved fish flash messages'
    set -l flash_messages_dir ~/.config/fish/flash_messages

    if set -q FLASH_MESSAGES_DIR
        set flash_messages_dir $FLASH_MESSAGES_DIR
    end

    if not test -d $flash_messages_dir
        return 0
    end

    set -l files (find $flash_messages_dir -type f | sort)

    if test (count $files) -gt 0
        echo "Flash messages:"

        for file in $files
            echo ""
            cat $file
        end

        echo ""
    end
end
