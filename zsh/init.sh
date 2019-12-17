#!/usr/bin/env zsh

## install .zshrc
rm -rf "$HOME/.oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
source ~/.zshrc
