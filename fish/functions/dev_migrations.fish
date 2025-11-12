function dev_migrations --description 'Prints out migration files on the current branch but not on master'
    if jj root --ignore-working-copy >/dev/null 2>&1
        jj diff --ignore-working-copy -r 'present(master)::@' --quiet --name-only 'glob:app/server/migrations/**' | rg "app/server/migrations/(\d+.+)" --replace '$1'
        or true
    end
end
