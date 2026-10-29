#!/usr/bin/env fish

@echo "Testing copy_selection_with_path function"

function pbcopy
    cat
end

set -gx ZED_RELATIVE_FILE "src/main.rs"
set -gx ZED_ROW 42

@test "copies selection with relative path and line" (
    set -gx ZED_SELECTED_TEXT "foo()"
    copy_selection_with_path
) = "foo() in src/main.rs:42"

@test "copies special characters as-is" (
    set -gx ZED_SELECTED_TEXT 'a "b" $HOME `x` \'q\' %s'
    copy_selection_with_path
) = 'a "b" $HOME `x` \'q\' %s in src/main.rs:42'

@test "keeps newlines in the selection" (
    set -gx ZED_SELECTED_TEXT "line1
line2"
    copy_selection_with_path | string collect
) = "line1
line2 in src/main.rs:42"
