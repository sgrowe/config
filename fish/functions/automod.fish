function automod --description 'Declare newly added Rust files in their parent module'
    set -l changed 0

    for line in (jj diff --summary)
        set -l file (string match -rg '^A (.+\.rs)$' -- $line)
        test -n "$file"
        or continue

        set -l base (path basename $file)

        # A crate root is not a module of anything
        if test "$base" = lib.rs -o "$base" = main.rs
            continue
        end

        # `foo/mod.rs` declares `foo` in the grandparent, `foo/bar.rs` declares
        # `bar` in `foo`'s own module file
        set -l name
        set -l dir
        if test "$base" = mod.rs
            set dir (path dirname (path dirname $file))
            set name (path basename (path dirname $file))
        else
            set dir (path dirname $file)
            set name (path change-extension '' $base)
        end

        set -l parent
        for candidate in $dir/mod.rs $dir.rs $dir/lib.rs $dir/main.rs
            if test -f $candidate
                set parent $candidate
                break
            end
        end

        if test -z "$parent"
            echo "automod: no parent module found for $file" >&2
            continue
        end

        set -l content (cat $parent)

        # Already declared at the top level of the parent. The pattern is
        # concatenated so `$name` isn't followed by a `[`, which fish would
        # otherwise read as a slice index.
        set -l declared '^(pub(\([^)]*\))?[ \t]+)?mod[ \t]+'$name'[ \t]*;'
        if string match -qr $declared -- $content
            continue
        end

        # Insert after the last top-level `mod` declaration; `cargo fmt` sorts
        # the group afterwards. 0 means the parent has none, so append instead.
        set -l insert_at 0
        for i in (seq (count $content))
            if string match -qr '^(pub(\([^)]*\))?[ \t]+)?mod[ \t]+[A-Za-z0-9_]+[ \t]*;' -- $content[$i]
                set insert_at $i
            end
        end

        set -l out
        for i in (seq (count $content))
            set -a out $content[$i]
            if test $i -eq $insert_at
                set -a out "pub mod $name;"
            end
        end
        if test $insert_at -eq 0
            set -a out "pub mod $name;"
        end

        printf '%s\n' $out >$parent
        echo "$parent: pub mod $name;"
        set changed 1
    end

    test $changed -eq 1
    and cargo fmt

    return 0
end
