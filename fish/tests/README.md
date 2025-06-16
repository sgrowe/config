# Fish Configuration Tests

This directory contains tests for the fish shell configuration functions and abbreviations.

## Running Tests

### Run all tests
```bash
# From the .config directory
fish -c 'fishtape fish/tests/*.fish'
```

### Run specific test file
```bash
# Run fishtape directly on an individual test file
fish -c 'fishtape fish/tests/test_jj_describe_abbr.fish'
```

## Test Files

- `test_jj_describe_abbr.fish` - Tests for the `_jj_describe_abbr` function that handles jj describe abbreviations

## Test Framework

We use [fishtape](https://github.com/jorgebucaran/fishtape) as our testing framework. It's a TAP (Test Anything Protocol) compliant test runner for Fish.

### Writing Tests

Tests are written using the `@test` function:

```fish
@test "description" (function_call "arg") = "expected_output"
```

Example:
```fish
@test "jm defaults to @-" (_jj_describe_abbr "jm") = "jj describe -r @- -m '%'"
```

### Test Structure

1. Source the configuration file to load functions
2. Use `@echo` for test section headers
3. Write individual test cases with descriptive names
4. Test edge cases and different input scenarios

## Adding New Tests

1. Create a new test file with the pattern `test_*.fish`
2. Make it executable: `chmod +x test_filename.fish`
3. Source the necessary configuration files
4. Write your test cases
5. Run the tests to ensure they pass

## Dependencies

- Fish shell
- fishtape (installed via Fisher)
- The functions being tested (from config.fish)
