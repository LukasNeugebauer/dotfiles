# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# define theme and configure it
ZSH_THEME="spaceship"


# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh/spaceship.zsh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Load some other scripts that contain aliases, credentials and environment variables
# This is to make sure that credentials don't accidentally get shared and to keep each file tidy
# load alises
[ -f "$HOME/.config/.aliases" ] && source "$HOME/.config/.aliases"
# load tokens
[ -f "$HOME/.config/.tokens" ] && source "$HOME/.config/.tokens"
# load environment variables
[ -f "$HOME/.config/.env-variables" ] && source "$HOME/.config/.env-variables"
# load shell functions
[ -f "$HOME/.config/.functions" ] && source "$HOME/.config/.functions"

# handle gcloud command line utility
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/l.neugebauer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/l.neugebauer/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/l.neugebauer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/l.neugebauer/google-cloud-sdk/completion.zsh.inc'; fi

# completely useless but looks cool and impresses normies
fastfetch

# Created by `pipx` on 2024-07-09 15:11:34
export PATH="$PATH:/Users/$USER/.local/bin"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# initialize rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# add uv completion for zsh
eval "$(uv generate-shell-completion zsh)"
