# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colorize python brew macos sudo)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
export EDITOR="hx"
export ALTERNATE_EDITOR="vim"
export GIT_EDITOR="hx"

# Automatically added stuff i should clean up.

# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Created by `pipx` on 2022-03-11 08:34:29
export PATH="$PATH:/Users/yash/.local/bin"

# stripe
fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

# bun completions
[ -s "/Users/yash/.bun/_bun" ] && source "/Users/yash/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/Users/yash/.deno/env"

# Aliases and custom configs
source "$ZDOTDIR/.yashrc"
