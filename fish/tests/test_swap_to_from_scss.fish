#!/usr/bin/env fish

@echo "Testing swap_to_from_scss function"

set -g tmpdir (mktemp -d)
set -g scss_file "$tmpdir/foo.scss"
set -g res_file "$tmpdir/foo.res"
set -g bsjs_file "$tmpdir/foo.bs.js"

echo "color: red;" > $scss_file
printf "hello\nworld\n" > $res_file
touch $bsjs_file

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

@test "open .res from .bs.js" (
    set -gx ZED_FILE $bsjs_file
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = $res_file

@test "fallback to .tsx if .res missing" (
    set -gx ZED_FILE $scss_file
    set -e ZED_SELECTED_TEXT
    rm $res_file
    set -g tsx_file "$tmpdir/foo.tsx"
    touch $tsx_file
    swap_to_from_scss
) = $tsx_file

rm -rf $tmpdir
