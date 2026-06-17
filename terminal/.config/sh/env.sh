export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

_path_add() {
    [ -d "${1}" ] &&
        PATH="${1}:${PATH}"
}
_path_add "${HOME}/.local/bin"
_path_add "${HOME}/.bin"
_path_add "${HOME}/.cargo/bin"
_path_add "${HOME}/.pulumi/bin"
_path_add "${HOME}/.local/bin/sources"
_path_add "${HOME}/.tfenv/bin"
_path_add "${HOME}/.local/share/bob/nightly/bin"

# Go
export GOPATH="$HOME/Code/go"
_path_add "$GOPATH/bin"
# Less
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
# Node / NPM
export NPM_PACKAGES="$XDG_CONFIG_HOME/npm-packages"
_path_add "$NPM_PACKAGES/bin"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# NVM
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# Locale
export LANG="en_GB.UTF-8"
export LC_CTYPE="en_GB.UTF-8"
# How do I get the pods? -- AlessioMinerva, 2024
export KUBE_CONFIG_PATH="${HOME}/.kube/config"
# Editor
if command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

export PATH
