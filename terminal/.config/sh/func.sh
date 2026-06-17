_dependency() {
    ! command -v "${1}" >/dev/null 2>&1 && {
        echo "You do not have ${1} installed."
        return 1
    }
}

_build_dir_list() {
    # this is a cool POSIX thing!
    for directory; do
        [ -d "${directory}" ] || continue

        find "${directory}" -maxdepth 1 -type d
    done
}

# fzf+tmux(or just plain ol' cd) Goodness
# Converted into a function from...
# https://github.com/ThePrimeagen/.dotfiles/pull/16
_switcher() {
    _dependency fzf

    dir_list=$(_build_dir_list \
        "${HOME}/Code/personal-gh" \
        "${HOME}/Code/work-gitlab" \
        "${HOME}/Code/work-gh" \
        "${HOME}/Code/work-azure" \
        "${HOME}/Code/work-bitbucket" \
        "${HOME}/Code/go/" \
        "${HOME}/Perforce/")

    other=$(echo "
        ${HOME}/.config/nvim
        ${HOME}/.config/sh
        " | sed -e 's/^[ \t]*//')

    selected=$(echo "${dir_list}${other}" | fzf)

    case "${1}" in
    # Open tmux in the directory
    t)
        _dependency tmux
        selected_name=$(basename "${selected}" | tr . _)

        if [ -n "${TMUX}" ]; then
            tmux switch-client -t "${selected_name}" ||
                tmux new-session -ds "${selected_name}" -c "${selected}" &&
                tmux switch-client -t "${selected_name}"
        elif [ -z "${TMUX}" ]; then
            tmux new-session -s "${selected_name}" -c "${selected}" ||
                tmux attach -t "${selected_name}"
        fi
        ;;
    # become the directory
    c)
        cd "${selected}"
        ;;
    *)
        echo "Unrecognised input to function: ${1}"
        return 1
        ;;
    esac
}

function t() {
    _switcher "t"
}

function c() {
    _switcher "c"
}
