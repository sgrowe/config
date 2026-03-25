#!/usr/bin/env fish

@echo "Testing flash_message_show function"

# --- No directory: returns 0, no output ---
set -l tmpdir (mktemp -d)
rm -rf $tmpdir
set -lx FLASH_MESSAGES_DIR $tmpdir

flash_message_show >/dev/null
@test "no directory returns 0" $status = 0

set -l out (flash_message_show | string collect)
@test "no directory prints nothing" -z "$out"

# --- Empty directory: returns 0, no output ---
set tmpdir (mktemp -d)
set -lx FLASH_MESSAGES_DIR $tmpdir

flash_message_show >/dev/null
@test "empty directory returns 0" $status = 0

set out (flash_message_show | string collect)
@test "empty directory prints nothing" -z "$out"

# --- Single message ---
echo "Hello world" >$tmpdir/msg1.txt

set out (flash_message_show | string collect)
set -l expected (printf 'Flash messages:\n\nHello world' | string collect)
@test "single message output" "$out" = "$expected"

# --- Multiple messages ---
echo "Second message" >$tmpdir/msg2.txt

set out (flash_message_show | string collect)
set expected (printf 'Flash messages:\n\nHello world\n\nSecond message' | string collect)
@test "multiple messages output" "$out" = "$expected"

# --- After clear: no output ---
flash_message --clear
set out (flash_message_show | string collect)
@test "after clear prints nothing" -z "$out"

rm -rf $tmpdir
