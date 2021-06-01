
export PATH=$HOME/.bin:/usr/local/bin:$PATH
neofetch
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# The following lines were added by compinstall
zstyle :compinstall filename '/home/pontus/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v='vim'
alias _='sudo'
alias pacin='sudo pacman -S'
alias pacun='sudo pacman -R'
alias pacloc='sudo pacman -Q'
alias game='$HOME/scripts/win10-launcher.sh'
source $HOME/.git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
