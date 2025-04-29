function linear_api
    set -f query "$(cat sam_misc/linear/my_tickets.graphql | jq -sR)"

    set -f data "$(echo $query | jq '{ query: . }')"

    curl \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: $LINEAR_API_KEY" \
        --data "$data" \
        https://api.linear.app/graphql \
        | jq
end