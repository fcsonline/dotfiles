#!/bin/bash

message ()
{
  RCOLOR=$(( ( RANDOM % 6 )  + 1 ))
  echo -e "Installing \033[1;3${RCOLOR}m$1\033[0m scripts..."
}

# SUBMODULES
pushd "${PWD}" || exit
  git submodule init > /dev/null 2>&1
  git submodule update > /dev/null 2>&1
popd || exit

# PACKAGES
message "Installing packages"
sudo apt update > /dev/null 2>&1
sudo apt install -qq -o Dpkg::Options::="--force-overwrite" -y "$(cat packages)" > /dev/null 2>&1

# TMUX
message "Tmux"
mkdir -p ~/.tmux/plugins
ln -snf "${PWD}/tmux/tmux.conf" ~/.tmux.conf
ln -snf "${PWD}/tmux/plugins/tpm" ~/.tmux/plugins/tpm
TMUX_PLUGIN_MANAGER_PATH="${HOME}/.tmux/plugins/" ~/.tmux/plugins/tpm/bin/install_plugins > /dev/null

# BASH
message "Bash"
ln -snf "${PWD}/bash/bashrc" ~/.bashrc
ln -snf "${PWD}/bash/bash_profile" ~/.bash_profile
ln -snf "${PWD}/bash/bash_aliases" ~/.bash_aliases
ln -snf "${PWD}/bash/inputrc" ~/.inputrc

# BASH FZF
message "FZF"
rm -rf ~/.fzf
git clone -q https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install > /dev/null 2>&1

# GIT
message "Git"
ln -sf "${PWD}/git/gitconfig" ~/.gitconfig

# NVIM
message "NVim"
ln -snf "${PWD}/nvim/" ~/.config/nvim

# nerd-fonts
curl -L -s -o /tmp/UbuntuMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip"
unzip -uq /tmp/UbuntuMono.zip -d ~/.local/share/fonts
curl -L -s -o /tmp/FiraCode.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
unzip -uq /tmp/FiraCode.zip -d ~/.local/share/fonts

# BYEBUG
message "Byebug"
ln -snf "${PWD}/byebugrc" ~/.byebugrc

# NOTES
message "Notes"
mkdir -p ~/.notes

# Execute it immediately
source ~/.bashrc
