export TERM=xterm-256color
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=${PATH}:/usr/local/mysql/bin
export PATH=$PATH:/usr/local/share/dotnet
# Path to your oh-my-zsh installation.
export ZSH=/Users/dmdinh/.oh-my-zsh
DEFAULT_USER=dmdinh
ZSH_THEME=powerlevel9k/powerlevel9k

# powerlvl9k config
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir node_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time battery custom_wifi_signal)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# CUSTOM PROMPT BARS/ICONS
POWERLEVEL9K_NODE_VERSION_BACKGROUND='022'
POWERLEVEL9K_NODE_ICON='\uf898'

# Right Prompt
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d/%m/%y}"
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND='cyan'

# VCS
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=true
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uf113'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='magenta'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch git-tagname)

for key in ${(k)icons[@]}
do
    if [[ ! $key =~ 'SEPARATOR' ]]
    then
        icons[$key]=" ${icons[$key]} "
    fi
done

# wifi signal strength
zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{black}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{black}'

                [[ $speed -gt 100 ]] && color='%F{black}'
                [[ $speed -lt 50 ]] && color='%F{red}'

                echo -n "%{$color%}$speed Mbps \uf1eb%{%f%}" # removed char not in my PowerLine font
        fi
}

# auto-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  git-completion
  vscode
  xcode
  z
  zsh-autosuggestions
)

# ALIASES
alias sourcezsh="source ~/.zshrc"
alias sourcebash="source ~/.bash_profile"
alias zshconfig="vim ~/.zshrc"
alias bashconfig="vim ~/bash_profle"
alias tmuxconfig="vim ~/.tmux.conf"
alias codezshdot="code ~/.zshrc"
alias lsa='colorls -dla'
alias ls='colorls'
alias vsc='code .'
alias cpsshkey='pbcopy < ~/.ssh/id_rsa.pub'
alias sshcode='ssh root@45.77.127.192'

# User configuration for Oh My ZSH
DISABLE_UPDATE_PROMPT=true

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

## NPM PATH REDIRECT $$
export PATH=/usr/local/share/npm/bin:$PATH
export PATH="$HOME/.npm-packages/bin:$PATH"

## NODE VERSION MANAGER ##
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"':
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## CHECK PROCESSES RUNNING ON PORT ##
function onPort() { lsof -nP -i4TCP:$@ | grep LISTEN; }

## DISABLE AUTOCORRECT
unsetopt correct_all

# Source files
source /Users/dmdinh/.bash_profile
source ~/.nvm/nvm.sh
source $ZSH/oh-my-zsh.sh
# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
stty erase '^?'
alias dotfiles='/usr/bin/git --git-dir=/Users/dmdinh/.dotfiles/ --work-tree=/Users/dmdinh'
alias dotfiles='/usr/bin/git --git-dir=/Users/dmdinh/.dotfiles/ --work-tree=/Users/dmdinh'
alias dotfiles='/usr/bin/git --git-dir=/Users/dmdinh/.dotfiles/ --work-tree=/Users/dmdinh'
