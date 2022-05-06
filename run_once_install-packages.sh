#!/bin/bash

echo "📦 Installing packages..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update > /dev/null 2>&1
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq -y $(cat packages) > /dev/null

echo "🔎 Installing FZF..."
rm -rf ~/.fzf
git clone -q https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
yes | ~/.fzf/install > /dev/null 2>&1

echo "💻 Installing Tmux plugins..."
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
TMUX_PLUGIN_MANAGER_PATH="${HOME}/.tmux/plugins/" ~/.tmux/plugins/tpm/bin/install_plugins > /dev/null

echo "㊙️ Installing Nerd fonts..."
mkdir -p ~/.local/share/fonts
curl -L -s -o /tmp/UbuntuMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"
unzip -uq /tmp/UbuntuMono.zip -d ~/.local/share/fonts
curl -L -s -o /tmp/FiraCode.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
unzip -uq /tmp/FiraCode.zip -d ~/.local/share/fonts
