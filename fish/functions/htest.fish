function htest
    if test (count $argv) -ne 1
        echo "Usage: htest <path>"
        return 1
    end

    set -l fullpath $argv[1]

    # Split by '/', grab fields 1 and 2
    set -l dirs (string split "/" -- $fullpath)[1 2]

    # Join back into a cwd path
    set -l cwd (string join "/" $dirs)

    # Construct the test path argument (everything after the first two folders)
    set -l rest (string split "/" -- $fullpath)[3..-1]
    set -l testpath (string join "/" $rest)

    # Execute the command
    zellij run --cwd "$cwd" -- pnpm run ava --watch "$testpath"
end
