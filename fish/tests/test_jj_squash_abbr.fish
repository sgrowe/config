@echo "Testing _jj_squash_abbr function"

@test "jsq expands to jj squash" (_jj_squash_abbr "jsq") = "jj squash"

@test "jsq- becomes @-" (_jj_squash_abbr "jsq-") = "jj squash --into @-"

@test "jsqol becomes ol" (_jj_squash_abbr "jsqol") = "jj squash --into ol"

@echo "All tests completed"
