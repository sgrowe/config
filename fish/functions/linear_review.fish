function linear_review
    argparse --min-args=1 -- $argv
    or return 1

    set -l gh_url $argv[1]

    set -l linear_url (string replace --regex 'https://github.com/(\w+)/(\w+)/pull/(\d+).*' 'https://linear.review/$1/$2/pull/$3' $gh_url)

    open $linear_url
end
