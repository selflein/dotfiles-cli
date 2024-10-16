source ~/.local/share/zinit/zinit.git/zinit.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit wait silent for \
    Aloxaf/fzf-tab \
    agkozak/zsh-z

zinit ice depth=1 atload'!source ~/.config/zsh/.p10k.zsh' lucid nocd
zinit light romkatv/powerlevel10k

zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf atpull"zinit creinstall -q ." \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
# Load fzf after vi-mode to prevent vi-mode from overwriting shortcuts of fzf
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

autoload -Uz bashcompinit && bashcompinit

## History file configuration
HISTSIZE=50000
SAVEHIST=50000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

setopt auto_menu
setopt always_to_end
setopt complete_in_word
setopt autocd
setopt magic_equal_subst  # Allow completions if they are structured like `opt=argument`

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# General environment variables 
# Put other environment variables into .zshenv

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore-vcs --full-path --type file --follow --exclude {.git,.cache}'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export FZF_ALT_C_COMMAND='fd --hidden --no-ignore-vcs --full-path --type directory --follow --exclude {.git,.cache}'

alias ls='ls --color=auto'
alias ssh='env TERM=xterm-256color ssh'

open() { xdg-open "$@" &> /dev/null &; disown; }

