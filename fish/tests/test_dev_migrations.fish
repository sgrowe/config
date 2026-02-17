#!/usr/bin/env fish

@echo "Testing dev_migrations function"

# Set up a temporary jj repo
set -l tmpdir (mktemp -d)
jj git init $tmpdir 2>/dev/null

# Create a migration file on "master" (the initial commit)
mkdir -p $tmpdir/app/server/migrations
echo "-- master migration" >$tmpdir/app/server/migrations/20260216135728_existing_migration.ts

# Commit it as master
jj --repository $tmpdir new root() -m "master commit" 2>/dev/null
jj --repository $tmpdir bookmark set master -r @- 2>/dev/null
jj --repository $tmpdir describe -m "master commit" 2>/dev/null

# Snapshot so jj tracks the file on master
jj --repository $tmpdir status >/dev/null 2>/dev/null

# Now create a branch commit that adds a second migration
jj --repository $tmpdir new -m "branch commit" 2>/dev/null
echo "-- branch migration" >$tmpdir/app/server/migrations/20260217100000_new_migration.ts

# Snapshot the working copy
jj --repository $tmpdir status >/dev/null 2>/dev/null

# Run dev_migrations from the temp repo and capture output
set -l result (
    cd $tmpdir
    dev_migrations
)

@test "only shows branch migration, not master migration" "$result" = "20260217100000_new_migration.ts"

rm -rf $tmpdir
