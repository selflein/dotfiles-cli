#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath -s $0))
cp -s $SCRIPT_PATH/.* ~

# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall


# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new-session -d "sleep 1"
sleep 0.1
~/.tmux/plugins/tpm/bin/install_plugins


# Zsh
chsh -s $(which zsh)
mkdir ~/.zplugin
git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
exec zsh
source ~/.zshrc
zplugin update --all
