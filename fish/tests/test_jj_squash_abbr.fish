@echo "Testing _jj_squash_abbr function"

@test "jsq expands to jj squash" (_jj_squash_abbr "jsq") = "jj squash"

@test "jsq- becomes @-" (_jj_squash_abbr "jsq-") = "jj squash --into @-"

@test "jsq-- becomes @--" (_jj_squash_abbr "jsq--") = "jj squash --into @--"

@test "jsq+ becomes @+" (_jj_squash_abbr "jsq+") = "jj squash --into @+"

@test "jsq-+ becomes @-+" (_jj_squash_abbr "jsq-+") = "jj squash --into @-+"

# Change IDs use k-z range
@test "jsqol becomes ol" (_jj_squash_abbr "jsqol") = "jj squash --into ol"

@test "jsqxy becomes xy" (_jj_squash_abbr "jsqxy") = "jj squash --into xy"

# Commit hashes (with hex digits outside k-z range)
@test "jsq123abc becomes 123abc" (_jj_squash_abbr "jsq123abc") = "jj squash --into 123abc"

@test "jsqabc123 becomes abc123" (_jj_squash_abbr "jsqabc123") = "jj squash --into abc123"

# Explicit @ in revision
@test "jsq@ becomes @" (_jj_squash_abbr "jsq@") = "jj squash --into @"

@test "jsq@- becomes @-" (_jj_squash_abbr "jsq@-") = "jj squash --into @-"

@echo "All tests completed"
