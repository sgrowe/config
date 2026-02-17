function dev_migrations --description 'Prints out migration files on the current branch but not on master'
    jj diff --ignore-working-copy --from 'present(master)' --to '@' --quiet --name-only 'glob:app/server/migrations/**' 2>/dev/null | rg "app/server/migrations/(\d+.+)" --replace '$1' | string collect
    or true
end
