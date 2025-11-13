
@echo "Testing _jj_describe_abbr function"

# Test basic case - just "jm" should default to "@-"
@test "jm defaults to @-" (_jj_describe_abbr "jm") = "jj describe -r @-"

# Test single dash - "jm-" should become "@-"
@test "jm- becomes @-" (_jj_describe_abbr "jm-") = "jj describe -r @-"

# Test double dash - "jm--" should become "@--"
@test "jm-- becomes @--" (_jj_describe_abbr "jm--") = "jj describe -r @--"

# Test triple dash - "jm---" should become "@---"
@test "jm--- becomes @---" (_jj_describe_abbr "jm---") = "jj describe -r @---"

# Test plus sign - "jm+" should become "@+"
@test "jm+ becomes @+" (_jj_describe_abbr "jm+") = "jj describe -r @+"

# Test mixed dashes and plus - "jm-+" should become "@-+"
@test "jm-+ becomes @-+" (_jj_describe_abbr "jm-+") = "jj describe -r @-+"

# Test alphanumeric revision - "jmxy" should become "xy"
@test "jmxy becomes xy" (_jj_describe_abbr "jmxy") = "jj describe -r xy"

# Test numeric revision - "jm123" should become "123"
@test "jm123 becomes 123" (_jj_describe_abbr "jm123") = "jj describe -r 123"

# Test alphanumeric with dashes - "jmabc-def" should become "abc-def"
@test "jmabc-def becomes abc-def" (_jj_describe_abbr "jmabc-def") = "jj describe -r abc-def"

# Test hash revision - "jm1a2b3c" should become "1a2b3c"
@test "jm1a2b3c becomes 1a2b3c" (_jj_describe_abbr "jm1a2b3c") = "jj describe -r 1a2b3c"

# Test longer revision - "jmfeature-branch" should become "feature-branch"
@test "jmfeature-branch becomes feature-branch" (_jj_describe_abbr "jmfeature-branch") = "jj describe -r feature-branch"

# Test with @ symbol already present - "jm@main" should become "@main"
@test "jm@main becomes @main" (_jj_describe_abbr "jm@main") = "jj describe -r @main"

@echo "All tests completed"
