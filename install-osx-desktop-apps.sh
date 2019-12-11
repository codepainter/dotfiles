#!/usr/bin/env bash
echo Installing desktop apps

set -e

source .cisupport/is_ci.sh

# Bypass upstream xattr issues with quarantine and latest OS X versions.  specifically, dropbox cask install failed
# TODO: remove me when a better solution is avail.
is_ci && export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications"

# Core
brew cask install \
    iterm2 \
    menumeters \
    mounty \
    qsync-client \
    rsyncosx \
    spotify \
    the-unarchiver \
    unified-remote \

# Install chat and stuff
brew cask install \
    slack \
    discord \
    telegram-desktop \
    whatsapp \

# Browsers & downloaders
brew cask install \
    firefox \
    google-chrome \
    jdownloader \
    megasync \
    qbittorrent \
    send-anywhere \

# Development
brew cask install \
    gitkraken \
    google-cloud-sdk \
    postman \
    adoptopenjdk8 \
    robo-3t \
    sublime-text \
    visual-studio-code \

# Others
brew cask install \
    renpy \
    steam \

# per Karabiner docs, need parent dir sym link, not json config sym link
ln -sf $(pwd)/karabiner $HOME/.config

# force reload after symlink creation
is_ci || launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server

ln -sf $(pwd)/hammerspoon $HOME/.hammerspoon

# Yah . . . this works, svn download a sub-dir of a github repo to a dest dir
svn export https://github.com/mattorb/keyboard/branches/customizations/hammerspoon hammerspoon/keyboard

is_ci || osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
is_ci || osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:true}' > /dev/null
is_ci || osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/nvALT.app", hidden:true}' > /dev/null

# Turn off Hammerspoon dock icon
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool FALSE
killall Hammerspoon || true
open /Applications/Hammerspoon.app
