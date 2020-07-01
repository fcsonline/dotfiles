#!/bin/bash

message ()
{
  RCOLOR=$(( ( RANDOM % 6 )  + 1 ))
  echo -e "Installing \033[1;3${RCOLOR}m$1\033[0m scripts..."
}

# TMUX
message "Tmux"
ln -snf "${PWD}/tmux/tmux.conf" ~/.tmux.conf
ln -snf "${PWD}/tmux/plugins" ~/.tmux-plugins

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

# VIM
message "Vim"
ln -snf "${PWD}/vimrc" ~/.vimrc
ln -snf "${PWD}/vim" ~/.vim
mkdir -p ~/.vim/{tmpdir,undodir}
chmod 700 ~/.vim/{tmpdir,undodir}

# BYEBUG
message "Byebug"
ln -snf "${PWD}/byebugrc" ~/.byebugrc

# NOTES
message "Notes"
mkdir -p ~/.notes

pushd "${PWD}"
  git submodule init > /dev/null 2>&1
  git submodule update > /dev/null 2>&1
popd

# PACKAGES
message "Installing packages"
cat packages | xargs sudo apt install -o Dpkg::Options::="--force-overwrite" -y

# Execute it immediately
source ~/.bashrc
