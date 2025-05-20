function linear_api
    set -f query "$(cat ~/.config/sam_misc/linear/$argv[1].graphql | jq -sR)"

    set -f data "$(echo $query | jq '{ query: ., variables: { teamId: env.LINEAR_TEAM_ID, teamIdStr: env.LINEAR_TEAM_ID } }')"

    curl \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: $LINEAR_API_KEY" \
        --data "$data" \
        https://api.linear.app/graphql \
        | jq
end
