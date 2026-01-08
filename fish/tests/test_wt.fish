@echo "Testing wt function"

@test "wt without args shows usage" (wt 2>&1) = "Usage: wt new <branch-name>"

@test "wt new without branch name shows usage" (wt new 2>&1) = "Usage: wt new <branch-name>"

@echo "All tests completed"
