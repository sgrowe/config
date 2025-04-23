function setup_symlinks
    # Print executed commands
    set -l fish_trace 1

    set -l vsc_settings "$HOME/Library/Application Support/Code/User/settings.json"
    set -l vsc_keymap "$HOME/Library/Application Support/Code/User/keybindings.json"

    # VS Code
    if not test -e $vsc_settings
        ln -s ~/.config/sam_misc/vscode/settings.json $vsc_settings
    end
    if not test -e $vsc_keymap
        ln -s ~/.config/sam_misc/vscode/keybindings.json $vsc_keymap
    end
end
