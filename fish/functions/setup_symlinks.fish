function setup_symlinks
    # Print executed commands
    set -l fish_trace 1

    set -l vsc_settings "$HOME/Library/Application Support/Code/User/settings.json"

    # VS Code settings
    if not test -e $vsc_settings
        ln -s ~/.config/sam_misc/vscode/settings.json $vsc_settings
    end
end
