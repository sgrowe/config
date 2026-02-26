#!/usr/bin/env fish

@echo "Testing flash_message function"

set -l tmpdir (mktemp -d)
set -lx FLASH_MESSAGES_DIR $tmpdir

@test "flash_message without args shows usage" (flash_message 2>&1) = "Usage: flash_message <message> | --clear"

flash_message "Remember to send standup"
set -l files (find $tmpdir -type f | wc -l | string trim)
@test "flash_message creates a file" $files = "1"

set -l shown (flash_message_show)
@test "flash_message_show prints saved messages" "$shown" = "Remember to send standup"

flash_message --clear
set -l remaining (find $tmpdir -type f | wc -l | string trim)
@test "flash_message --clear removes all files" $remaining = "0"

flash_message "Another reminder"
flash_message —clear
set -l remaining_after_em_dash (find $tmpdir -type f | wc -l | string trim)
@test "flash_message —clear also removes all files" $remaining_after_em_dash = "0"

rm -rf $tmpdir
