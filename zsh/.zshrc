if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
bindkey '^I' autosuggest-accept
# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh
ZSH_CUSTOM=$ZSH/custom

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

export MANPATH="$MANPATH:/usr/local/man"
export PAGER='bat --color always --style=plain'
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/libstdc++.so.6:/usr/lib/"
export ROS_DOMAIN_ID=42

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
else
   export EDITOR='nvim'
fi

ENABLE_CORRECTION="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting colored-man-pages)
source $ZSH/oh-my-zsh.sh

# setopt GLOB_DOTS
setopt SHARE_HISTORY

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh_aliases

# source /opt/ros/jazzy-base/setup.zsh
# source /usr/share/gazebo/setup.sh
# source ~/ros2_ws/install/setup.zsh
