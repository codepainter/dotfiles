#!/usr/bin/env zsh

## install zsh and ohmyzsh
echo removing previous ohmyzsh installation
rm -rf "$HOME/.oh-my-zsh"
rm "$HOME/.zshrc"
echo Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## user dotfiles .zshrc
echo Linking dotfiles/zsh/.zshrc
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
echo Sourcing .zshrc
source "$HOME/.zshrc"
