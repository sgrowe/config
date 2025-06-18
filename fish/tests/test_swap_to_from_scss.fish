#!/usr/bin/env fish

@echo "Testing swap_to_from_scss function"

set -g tmpdir (mktemp -d)
set -g scss_file "$tmpdir/foo.scss"
set -g res_file "$tmpdir/foo.res"

echo "color: red;" > $scss_file
printf "hello\nworld\n" > $res_file

function zed
    echo $argv
end

@test "open .res from .scss" (
    set -gx ZED_FILE $scss_file
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = $res_file

@test "open .scss from .res" (
    set -gx ZED_FILE $res_file
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = $scss_file

@test "open .res at matched line" (
    set -gx ZED_FILE $scss_file
    set -gx ZED_SELECTED_TEXT "world"
    swap_to_from_scss
) = "$res_file:2"

rm -rf $tmpdir
