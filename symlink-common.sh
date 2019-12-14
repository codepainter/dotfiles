#!/bin/bash

ln -sf $(pwd)/git/.gitaliases $HOME/.gitaliases

# [ -d $HOME/.config/fish ] || mkdir -p $HOME/.config/fish
# ln -sf $(pwd)/fish/functions "$HOME/.config/fish"
# ln -sf $(pwd)/fish/config.fish "$HOME/.config/fish/config.fish"

ln -sf $(pwd)/bin $HOME
