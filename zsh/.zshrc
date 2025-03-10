# Initialize powerlevel10k
# TODO: consider moving this as a submodule of this repo
source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
source "$ZDOTDIR/.p10k.zsh"

# ------------- Plugins -----------------
# Shift + Select: https://github.com/jirutka/zsh-shift-select
source "$ZDOTDIR/plugins/zsh-shift-select.plugin.zsh"

# zsh-defer plugin to defer zsh commands: https://github.com/romkatv/zsh-defer
source "$ZDOTDIR/plugins/zsh-defer.plugin.zsh"

# evalcache to speed up subsequent shell loads: https://github.com/mroth/evalcache
source "$ZDOTDIR/plugins/zsh-evalcache.plugin.zsh"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# git completions
autoload -Uz compinit && compinit

# ------------- Custom -----------------
# Aliases and custom configs
source "$ZDOTDIR/.yashrc"

# ------------- Plugins -----------------

# zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting/
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

