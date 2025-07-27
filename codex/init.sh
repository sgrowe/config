#!/bin/bash

# Initialize Codex environment

set -euxo pipefail

# Link fish config dir
mkdir -p ~/.config
ln -s $(pwd)/fish ~/.config/fish

# Install fish shell
add-apt-repository -y ppa:fish-shell/release-4

apt update -y

apt install -y fish ripgrep fzf

# Install fish plugins
fish -c 'fisher update'
