function recent_branches --description "Show the most recently used git branches"
    git reflog show --pretty=format:'%gs' | grep 'checkout' | awk '{print $NF}' | awk '!seen[$0]++' | head -n 10
end
