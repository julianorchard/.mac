# vim: ft=sh :

# This is basically the file for all the weird ZSH things I don't understand
# and don't WANT to understand... anything I've actually added is in the
# ~/.config/sh/ location

# Load colours
autoload -U colors && colors

# Do the prompt
autoload -Uz vcs_info
precmd() {
    vcs_info
}
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT=' %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# git completion
fpath=(~/.zsh $fpath)
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select() {
    case $KEYMAP in
    vicmd) echo -ne '\e[1 q' ;;        # block
    viins | main) echo -ne '\e[5 q' ;; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.

# Ctrl+R to search backwards in history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
bindkey -v
bindkey '^R' history-incremental-search-backward

# Don't need to type cd anymore
setopt autocd

# Non-OMZ Config
. ~/.config/sh/aliases.sh
. ~/.config/sh/env.sh
. ~/.config/sh/func.sh
. ~/.zshrc-aliases # Not in the dotfiles please
