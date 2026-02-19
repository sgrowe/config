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

## Tests for extended extension support (.ts, .js) and new fallback (.tsx)

set -g tmpdir2 (mktemp -d)

@test "open .ts from .scss when .ts exists (no .res)" (
    set -l bar_scss "$tmpdir2/bar.scss"
    set -l bar_ts "$tmpdir2/bar.ts"
    touch $bar_scss $bar_ts
    set -gx ZED_FILE $bar_scss
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = "$tmpdir2/bar.ts"

@test "open .js from .scss when .js exists (no .res, .ts, .tsx)" (
    set -l baz_scss "$tmpdir2/baz.scss"
    set -l baz_js "$tmpdir2/baz.js"
    touch $baz_scss $baz_js
    set -gx ZED_FILE $baz_scss
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = "$tmpdir2/baz.js"

@test "fallback to .tsx when no corresponding files exist" (
    set -l qux_scss "$tmpdir2/qux.scss"
    touch $qux_scss
    set -gx ZED_FILE $qux_scss
    set -e ZED_SELECTED_TEXT
    swap_to_from_scss
) = "$tmpdir2/qux.tsx"

rm -rf $tmpdir $tmpdir2
