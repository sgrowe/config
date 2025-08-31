
@echo "Testing _jj_describe_abbr_no_msg function"

# Test basic case - just "jds" should default to "@"
@test "jds defaults to @" (_jj_describe_abbr_no_msg "jds") = "jj describe -r @"

# Test single dash - "jds-" should become "@-"
@test "jds- becomes @-" (_jj_describe_abbr_no_msg "jds-") = "jj describe -r @-"

# Test double dash - "jds--" should become "@--"
@test "jds-- becomes @--" (_jj_describe_abbr_no_msg "jds--") = "jj describe -r @--"

# Test triple dash - "jds---" should become "@---"
@test "jds--- becomes @---" (_jj_describe_abbr_no_msg "jds---") = "jj describe -r @---"

# Test plus sign - "jds+" should become "@+"
@test "jds+ becomes @+" (_jj_describe_abbr_no_msg "jds+") = "jj describe -r @+"

# Test mixed dashes and plus - "jds-+" should become "@-+"
@test "jds-+ becomes @-+" (_jj_describe_abbr_no_msg "jds-+") = "jj describe -r @-+"

# Test alphanumeric revision - "jdstv" should become "tv"
@test "jdstv becomes tv" (_jj_describe_abbr_no_msg "jdstv") = "jj describe -r tv"

# Test numeric revision - "jds123" should become "123"
@test "jds123 becomes 123" (_jj_describe_abbr_no_msg "jds123") = "jj describe -r 123"

# Test alphanumeric with dashes - "jdsabc-def" should become "abc-def"
@test "jdsabc-def becomes abc-def" (_jj_describe_abbr_no_msg "jdsabc-def") = "jj describe -r abc-def"

# Test hash revision - "jds1a2b3c" should become "1a2b3c"
@test "jds1a2b3c becomes 1a2b3c" (_jj_describe_abbr_no_msg "jds1a2b3c") = "jj describe -r 1a2b3c"

# Test longer revision - "jdsfeature-branch" should become "feature-branch"
@test "jdsfeature-branch becomes feature-branch" (_jj_describe_abbr_no_msg "jdsfeature-branch") = "jj describe -r feature-branch"

# Test with @ symbol already present - "jds@main" should become "@main"
@test "jds@main becomes @main" (_jj_describe_abbr_no_msg "jds@main") = "jj describe -r @main"

@echo "All tests completed"

