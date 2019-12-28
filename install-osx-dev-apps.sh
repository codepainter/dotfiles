#!/usr/bin/env bash
echo Configuring mac

set -e

source .cisupport/is_ci.sh

if [[ $(xcode-select --version) ]]; then
  echo Xcode command tools already installed
else
  echo "Installing Xcode commandline tools"
  $(xcode-select --install)
fi

if [[ $(brew --version) ]]; then
  echo "Attempting to update Homebrew"
  brew update
else
  echo "Attempting to install Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# Bypass upstream xattr issues with quarantine and latest OS X versions.  specifically, quicklook-csv cask install failed
# TODO: remove me when a better solution is avail.
is_ci && export HOMEBREW_CASK_OPTS="--no-quarantine --appdir=/Applications"

brew update
brew cask upgrade
brew cleanup

echo Effective Homebrew version:
brew --version

brew bundle --file=- <<-EOS
tap "beeftornado/rmtree"
tap "homebrew/cask"
tap "homebrew/cask-drivers"
tap "homebrew/cask-versions"
tap "mongodb/brew"
tap "heroku/brew"
brew "git"
brew "goenv"
brew "pyenv"
brew "nodenv"
brew "awscli"
brew "yarn"
brew "zip"
brew "nnn"
brew "curl"
brew "mongodb-community"
brew "elasticsearch"
brew "redis"
brew "heroku"
EOS

echo Installing Node:
nodenv install 8.16.2 --skip-existing
nodenv install 9.11.2 --skip-existing
nodenv install 10.17.0 --skip-existing
nodenv install 11.15.0 --skip-existing
nodenv install 12.13.1 --skip-existing
nodenv install 13.2.0 --skip-existing

echo Installing Python:
pyenv install 2.7.17 --skip-existing
pyenv install 3.8.0 --skip-existing

echo Installing Go:
goenv install 1.9.7 --skip-existing
goenv install 1.10.7 --skip-existing
goenv install 1.11.4 --skip-existing
goenv global 1.11.4

echo Installing storages:
brew bundle --file=- <<-EOS
brew "mongodb-community"
brew "elasticsearch"
brew "redis"
EOS

# brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package quicklookase qlvideo

echo Installing other shells:
brew bundle --file=- <<-EOS
brew "bash"
brew "zsh"
EOS

# echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
# is_ci || sudo -v
# is_ci || sudo chsh -s /usr/local/bin/fish $(whoami)

# fisher for completions. 3.2.7
# curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
# is_azure_devops || fish -c "fisher add barnybug/docker-fish-completion"
# is_azure_devops || fish -c "fisher add ansible-completion"
# is_azure_devops || fish -c "fisher add jethrokuan/fzf"
# is_azure_devops || fish -c "fisher add derphilipp/enter-docker-fzf"

echo Installing Development Casks:
brew cask install \
  docker \
  adoptopenjdk8 \
  visual-studio-code \
  gitkraken \
  google-cloud-sdk \
  postman \
  robo-3t \
  sublime-text

# set +e # give virtualbox install a pass on github action CI   Fails for because the security panel is not openable from CI

# if [[ $(brew cask install virtualbox) ]] ; then
#     echo VirtualBox installed.
# else
#     echo VirtualBox install second attempt.
#     echo "open/reopen System Preferences → Security & Privacy → General and allow Oracle kernel addon"
#     read -p "Do you wish to resume install (y/n)?" yn

#     echo "Attempting to install virtualbox"
#     brew cask install virtualbox
# fi

# set -e

# Equivalent of VS [gui] Command Palette  "Shell command: Install 'code' command in PATH"
ln -sf /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code

echo Installing VSCode extensions:
# code --install-extension lunaryorn.fish-ide
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension ms-azuretools.vscode-cosmosdb
code --install-extension wwm.better-align
code --install-extension aaron-bond.better-comments
code --install-extension alefragnani.bookmarks
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension googlecloudtools.cloudcode
code --install-extension mikestead.dotenv
code --install-extension dbaeumer.vscode-eslint
code --install-extension skyapps.fish-vscode
code --install-extension fatihacet.gitlab-workflow
code --install-extension eamodio.gitlens
code --install-extension ms-vscode.go
code --install-extension xabikos.javascriptsnippets
code --install-extension orta.vscode-jest
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension shanoor.vscode-nginx
code --install-extension waderyan.nodejs-extension-pack
code --install-extension eg2.vscode-npm-script
code --install-extension howardzuo.vscode-npm-dependency
code --install-extension christian-kohler.npm-intellisense
code --install-extension ms-azuretools.vscode-docker
code --install-extension christian-kohler.path-intellisense
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.python
code --install-extension jasonnutter.search-node-modules
code --install-extension foxundermoon.shell-format
code --install-extension gruntfuggly.todo-tree
code --install-extension vscode-icons-team.vscode-icons
code --install-extension gamunu.vscode-yarn
# code --install-extension haaaad.ansible

ln -sf $(pwd)/prefs/visual-studio-code/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf $(pwd)/prefs/visual-studio-code/.prettierrc "$HOME/.prettierrc"

# only installed when osx, so not in the base template
git config --global core.editor "code -w -n"
# git config --global core.pager "diff-so-fancy | less --tabs=1,5 -R"
# git config --global pull.rebase true
# git config --global rebase.autoStash true

# git config --global difftool.prompt false
# git config --global merge.tool p4mergetool
# git config --global mergetool.p4mergetool.cmd "/usr/local/bin/p4merge \$PWD/\$BASE \$PWD/\$LOCAL \$PWD/\$REMOTE \$PWD/\$MERGED"
# git config --global mergetool.p4mergetool.trustExitCode false
# git config --global mergetool.keepBackup false

# git config --global diff.tool p4mergetool
# git config --global difftool.p4mergetool.cmd "/usr/local/bin/p4merge \$LOCAL \$REMOTE"
# git config --global difftool.p4mergetool.prompt false

cd src/listrepo
./build.sh
cd ../../

echo '1.  Execute this to add ssh key (w/passphrase) to keychain:  ssh-add -K ~/.ssh/id_rsa'
echo '2.  Then git config --global user.name "Your Name"'
echo '3.  Then git config --global user.email "Your_Email@...com"'
echo '4.  Create a git Personal Access token, then:  "hub browse" and enter git user and Access token to configure hub to use that'
echo '5.  Configure dropbox accounts'
echo '6.  Configure Slack accounts'
echo '7.  Configure nvalt storage backend /Dropbox/Notes'
echo '8.  Install Air Mail from App Store and configure accounts'
echo '9.  Add Bartender license, configure bartender'
echo '10. Configure 1Password vaults'
echo '11. Install IDEs'
echo '12. Add cdto to finder toolbar:   Drag Applications/cd to.app onto the Finder toolbar while holding down the command(⌘) and option(⌥) keys'
echo '13. Configure ARQ'
echo '14. Configure Carbon Copy cloner'
echo '15. Launch Spectacle and enable accessibility access.  Then menubar->spectacle->Preferences->Launch at login'
echo '16. Put a github token in ~/.fhub_token to enable the fhub repo navigation function.  Put additional orgs (to include their public repos) in ~/.fhub_orgs'
echo '17. Open security preferences and grant access to Karabiner Elements for keyboard mapping'
echo '18. Launch Karabiner Elements and answer any prompts to describe active keyboard type'
echo '19. Launch Hammerspoon.  Set it to start on launch.   Enable Accessibility.'
echo '20. Configure Tunnelblick VPN.'
