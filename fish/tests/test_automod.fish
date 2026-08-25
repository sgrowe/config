#!/usr/bin/env fish

@echo "Testing automod function"

set -g automod_tmpdir (mktemp -d)
set -g automod_cargo_log $automod_tmpdir/cargo_calls
set -g AUTOMOD_DIFF

# Stub out the two commands automod shells out to
function jj
    if test "$argv[1]" = diff
        printf '%s\n' $AUTOMOD_DIFF
    end
end

function cargo
    echo $argv >>$automod_cargo_log
end

## 1. A plain new module is declared after the last existing `mod` line

set -l case1 $automod_tmpdir/plain
mkdir -p $case1/src
printf 'pub mod app_state;\npub mod bolus;\n\npub use app_state::AppState;\n' >$case1/src/lib.rs
touch $case1/src/app_state_builder.rs

set AUTOMOD_DIFF "A src/app_state_builder.rs"
: >$automod_cargo_log

pushd $case1
set -l case1_output (automod)
set -l case1_lines (cat src/lib.rs)
popd

@test "declares the new module in src/lib.rs" "$case1_lines[3]" = "pub mod app_state_builder;"
@test "keeps the existing declarations" "$case1_lines[1]" = "pub mod app_state;"
@test "keeps the rest of the file" "$case1_lines[5]" = "pub use app_state::AppState;"
@test "reports what it declared" "$case1_output" = "src/lib.rs: pub mod app_state_builder;"

## 9a. cargo fmt runs exactly once when something changed

set -l case1_fmt_calls (wc -l <$automod_cargo_log | string trim)
@test "runs cargo fmt once when a module was declared" $case1_fmt_calls = 1

## 2. An added mod.rs declares its directory in the grandparent

set -l case2 $automod_tmpdir/modrs
mkdir -p $case2/src/effects/routes
printf 'pub mod registry;\n' >$case2/src/effects/mod.rs
touch $case2/src/effects/routes/mod.rs

set AUTOMOD_DIFF "A src/effects/routes/mod.rs"

pushd $case2
automod >/dev/null
set -l case2_lines (cat src/effects/mod.rs)
popd

@test "declares the directory, not mod" "$case2_lines[2]" = "pub mod routes;"

## 3. A nested module resolves to a 2018-style <dir>.rs parent

set -l case3 $automod_tmpdir/dirfile
mkdir -p $case3/src/effects/registry
printf 'use crate::Effect;\n\npub mod resolve;\n' >$case3/src/effects/registry.rs
touch $case3/src/effects/registry/storage.rs

set AUTOMOD_DIFF "A src/effects/registry/storage.rs"

pushd $case3
automod >/dev/null
set -l case3_lines (cat src/effects/registry.rs)
popd

@test "declares the module in the sibling <dir>.rs" "$case3_lines[4]" = "pub mod storage;"

## 4. Running twice declares nothing the second time

set AUTOMOD_DIFF "A src/app_state_builder.rs"

: >$automod_cargo_log

pushd $case1
set -l case4_stderr (automod 2>&1 >/dev/null)
set -l case4_count (grep -c '^pub mod app_state_builder;$' src/lib.rs | string trim)
set -l case4_total (wc -l <src/lib.rs | string trim)
popd

set -l case4_fmt_calls (wc -l <$automod_cargo_log | string trim)

@test "does not declare the same module twice" $case4_count = 1
@test "leaves the file otherwise untouched" $case4_total = 5
@test "says nothing on stderr when already declared" "$case4_stderr" = ""
@test "does not run cargo fmt when already declared" $case4_fmt_calls = 0

## 5. Modified files and non-Rust additions are ignored

set -l case5 $automod_tmpdir/ignored
mkdir -p $case5/src
printf 'pub mod app_state;\n' >$case5/src/lib.rs
printf 'notes\n' >$case5/src/notes.txt

set AUTOMOD_DIFF "M src/lib.rs" "M src/app_state.rs" "A src/notes.txt" "A README.md"
: >$automod_cargo_log

pushd $case5
automod >/dev/null
set -l case5_lines (cat src/lib.rs)
popd

@test "ignores modified files and non-Rust additions" (count $case5_lines) = 1

## 9b. cargo fmt does not run when nothing changed

set -l case5_fmt_calls (wc -l <$automod_cargo_log | string trim)
@test "does not run cargo fmt when nothing changed" $case5_fmt_calls = 0

## 6. Added crate roots are skipped

set -l case6 $automod_tmpdir/roots
mkdir -p $case6/src
printf 'pub mod app_state;\n' >$case6/src/lib.rs
printf 'fn main() {}\n' >$case6/src/main.rs

set AUTOMOD_DIFF "A src/lib.rs" "A src/main.rs"

pushd $case6
automod >/dev/null
set -l case6_lines (cat src/lib.rs)
popd

@test "skips added crate roots" "$case6_lines" = "pub mod app_state;"

## 7. A file with no parent module warns on stderr and changes nothing

set -l case7 $automod_tmpdir/noparent
mkdir -p $case7/tests/common
touch $case7/tests/common/mod.rs

set AUTOMOD_DIFF "A tests/common/mod.rs"

pushd $case7
set -l case7_warning (automod 2>&1 >/dev/null)
set -l case7_status $status
set -l case7_files (find . -name '*.rs' | wc -l | string trim)
popd

@test "warns when there is no parent module" "$case7_warning" = "automod: no parent module found for tests/common/mod.rs"
@test "still exits successfully" $case7_status = 0
@test "writes nothing when there is no parent" $case7_files = 1

## 8. A parent with no `mod` declarations gets the line appended

set -l case8 $automod_tmpdir/nomods
mkdir -p $case8/src
printf 'use std::fmt;\n\npub struct App;\n' >$case8/src/lib.rs
touch $case8/src/app_state.rs

set AUTOMOD_DIFF "A src/app_state.rs"

pushd $case8
automod >/dev/null
set -l case8_lines (cat src/lib.rs)
popd

@test "appends when the parent has no mod declarations" "$case8_lines[4]" = "pub mod app_state;"
@test "appends at the end of the file" (count $case8_lines) = 4

functions -e jj cargo
rm -rf $automod_tmpdir
