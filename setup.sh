#!/bin/bash
echo 'setup dotfiles'
cp ./.zshrc ~/.zshrc
cp ./.zshrc ~/.zshrc_`uname`
cp ./.gitconfig ~/.gitconfig
cp ./.tmux.conf ~/.tmux.conf
cp ./.spacemacs ~/.spacemacs
echo 'done'
