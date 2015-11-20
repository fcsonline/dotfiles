#!/bin/bash

message ()
{
  RCOLOR=$(( ( RANDOM % 6 )  + 1 ))
  echo -e "Installing \033[1;3${RCOLOR}m$1\033[0m scripts..."
}

# BASH
message "Bash"
ln -sf ${PWD}/bash/bashrc ~/.bashrc
ln -sf ${PWD}/bash/bash_profile ~/.bash_profile
ln -sf ${PWD}/bash/bash_aliases ~/.bash_aliases
ln -sf ${PWD}/bash/inputrc ~/.inputrc

# BASH FZF
message "FZF"
rm -rf ~/.fzf
git clone -q https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install > /dev/null 2>&1

# GIT
message "Git"
ln -sf ${PWD}/git/gitconfig ~/.gitconfig

# VIM
message "Vim"
ln -sf ${PWD}/vimrc ~/.vimrc
ln -sf ${PWD}/vim ~/.vim
mkdir -p ~/.vim/{tmpdir,undodir}
chmod 700 ~/.vim/{tmpdir,undodir}

pushd ${PWD}
  git submodule init > /dev/null 2>&1
  git submodule update > /dev/null 2>&1
popd

# Execute it immediately
source ~/.bashrc
