export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# PATH (Muy importante)
path+=(
  "$HOME/.local/bin"
  "/usr/local/go/bin"
  "$HOME/go/bin"
)
export PATH

#### ALIASES (EZA) ####
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -alF -g --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias l.='eza -a | grep "^\."'
alias ldir='eza -aD'
alias lfile='eza -af'
