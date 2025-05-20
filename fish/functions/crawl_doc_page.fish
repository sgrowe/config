function crawl_doc_page
    argparse --min-args=1 -- $argv
    or return 1

    set -l url $argv[1]

    set -l parts (string split '/' $url)
    set -l name $parts[-1]

    # Download the HTML content
    curl $url > docs/$name.html

    # Process the HTML content
    strip-tags '.content' -t hs -t code -t tables < docs/$name.html > docs/$name.min.html
end
