# Set the directory for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if it's not setup yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

export EDITOR=/usr/bin/vi
export GIT_EDITOR=/usr/bin/vi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Setup Starship
eval "$(starship init zsh)"

# Load completions
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

# Zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
## Oh My Zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::aliases
zinit snippet OMZP::copyfile
zinit snippet OMZP::copypath
zinit snippet OMZP::debian
zinit snippet OMZP::dircycle
zinit snippet OMZP::ssh
zinit snippet OMZP::vi-mode

# Replay cached completions - recommended by docs
zinit cdreplay -q

# Setup Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Use Emacs keybindings
bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
# Allow lower case searches to match uppercase results
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Apply colours to suggestions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Disable default zsh completion menu - replaced by fzf-tab
zstyle ':completion:*' menu no
# Show directory preview when auto compelting
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ll='ls -lah'

alias g='git'

# Shell integrations
## Fuzzy Finder
eval "$(fzf --zsh)"
## ZOxide
eval "$(zoxide init zsh --cmd cd)"
