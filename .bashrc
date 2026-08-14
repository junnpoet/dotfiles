# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
source /usr/share/fzf/key-bindings.bash 2>/dev/null || source ~/.fzf.bash
source /usr/share/fzf/completion.bash 2>/dev/null

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

function ff {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
  if [ -n "$file" ]; then
    ${EDITOR:-nvim} "$file"
  fi
}

export PATH=$OMARCHY_PATH/bin:$PATH:$HOME/.local/bin:$HOME/go/bin
