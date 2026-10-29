function copy_selection_with_path
    printf '%s in %s:%s' "$ZED_SELECTED_TEXT" "$ZED_RELATIVE_FILE" "$ZED_ROW" | pbcopy
end
