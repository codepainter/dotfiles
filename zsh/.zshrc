# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow aws yarn npm web-search gcloud zsh_reload pyenv heroku docker docker-compose redis-cli)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nano'
else
    export EDITOR='subl'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

alias dotfiles="code ~/dotfiles"
alias ohmyzsh="code ~/.oh-my-zsh"
alias sz="source ~/.zshrc"
alias shutdown='sudo shutdown -h now'

alias cp='cp -iv'                         # Preferred 'cp' implementation
alias mv='mv -iv'                         # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                   # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                     # Preferred 'ls' implementation
alias llt='ll -t'                         # Preferred 'll -t' implementation
alias lltr='ll -tr'                       # Preferred 'll -tr' implementation
alias less='less -FSRXc'                  # Preferred 'less' implementation
cd() {
    builtin cd "$@"
    ll
} # Always list directory contents upon 'cd'
alias cd..='cd ../'                       # Go back 1 directory level (for fast typers)
alias ..='cd ../'                         # Go back 1 directory level
alias ...='cd ../../'                     # Go back 2 directory levels
alias .3='cd ../../../'                   # Go back 3 directory levels
alias .4='cd ../../../../'                # Go back 4 directory levels
alias .5='cd ../../../../../'             # Go back 5 directory levels
alias .6='cd ../../../../../../'          # Go back 6 directory levels
alias edit='subl'                         # edit:         Opens any file in sublime editor
alias sublime='subl'                      # sublime alias
alias f='open -a Finder ./'               # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                            # ~:            Go Home
alias c='clear'                           # c:            Clear terminal display
alias which='type -all'                   # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'       # path:         Echo all executable Paths
alias show_options='shopt'                # Show_options: display bash options settings
alias fix_stty='stty sane'                # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On' # cic:          Make tab-completion case-insensitive
mcd() { mkdir -p "$1" && cd "$1"; }       # mcd:          Makes new Dir and jumps inside

alias brewUpdate='brew update && brew upgrade && brew cleanup && upgrade_oh_my_zsh && nodenv rehash && pyenv rehash && goenv rehash'
alias burp='brewUpdate'

ziptocbz() {
    for i in */; do
        zip -rmv "${i%/}.cbz" "$i"
    done
}

#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias myip='curl ifconfig.co/json | json_pp' # myip:         Public facing IP Address
alias myif='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias netCons='lsof -i'                           # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'          # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'           # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP' # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP' # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'            # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'            # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'      # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC "
    uname -a
    echo -e "\n${RED}Users logged on:$NC "
    w -h
    echo -e "\n${RED}Current date :$NC "
    date
    echo -e "\n${RED}Machine stats :$NC "
    uptime
    echo -e "\n${RED}Current network location :$NC "
    scselect
    echo -e "\n${RED}Local IP Address :$NC "
    myif
    echo -e "\n${RED}Public facing IP Address :$NC "
    myip
    #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

eval "$(nodenv init -)"
eval "$(goenv init -)"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
