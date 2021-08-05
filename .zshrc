
PATH=$HOME/.bin:/usr/local/bin:/usr/bin/env:/opt:$HOME/.local/bin:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1
export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311
neofetch
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -U colors && colors	# Load colors
PROMPT="%B%F{30}%n%f%b%B@%b%B%F{30}%m %f%b%B%~%b%B » %b"
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pontus/.zshrc'

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Enable vim key
set -o vi
bindkey -v
# End of lines added by compinstall
# Change cursor in Vi-mode
# Change cursor shape for different vi modes.
function zle-keymap-select () {
  case $KEYMAP in
       vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Define aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vpnon="sudo openvpn --config /home/pontus/pontuspc.ovpn --daemon > /dev/null 2>&1"
alias vpnoff="sudo killall openvpn"
alias mosh='mosh --no-init'
alias v='nvim'
alias s='sudo'
alias pacin='sudo pacman -S'
alias pacun='sudo pacman -R'
alias pacloc='sudo pacman -Q'
alias game='win10-launcher.sh'
alias pacupg="sudo pacman -Syu"
alias lsl='ls -la --color=auto'
alias ls='ls --color=auto'
alias sysre='systemctl --user restart spotifyd.service'

# Load some plugins
source $HOME/.git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.git/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.git/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source /opt/ros/noetic/setup.zsh
