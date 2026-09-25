# ------------------------------------
# Oh My Zsh
# ------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# ------------------------------------
# Command autocomplete
# https://tcude.net/enabling-command-autocomplete-in-zsh/
# ------------------------------------
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# ------------------------------------
# Editor
# ------------------------------------
export EDITOR="code --wait"

# ------------------------------------
# Exports & aliases (~/.zsh -> dotfiles/zsh)
# ------------------------------------
[ -f ~/.zsh/exports ] && source ~/.zsh/exports
[ -f ~/.zsh/aliases ] && source ~/.zsh/aliases

# ------------------------------------
# Machine-specific overrides (not committed)
# ------------------------------------
[ -f ~/.machine-specific ] && source ~/.machine-specific
