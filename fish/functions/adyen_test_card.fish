function adyen_test_card --description "Copy Adyen test card number to clipboard"
    # https://docs.adyen.com/development-resources/testing/test-card-numbers/#mastercard
    echo "5555 4444 3333 1111" | fish_clipboard_copy
end
