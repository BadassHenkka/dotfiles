#!/bin/bash

declare -r DOT=$HOME/dotfiles

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "$DOT/setup/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_bash_local() {

    declare -r FILE_PATH="$HOME/.bash.local"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

   if [ ! -e "$FILE_PATH" ] || [ -z "$FILE_PATH" ]; then

        DOTFILES_BIN_DIR="$(dirname "$(pwd)")/bin/"

        printf "%s\n" \
"#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set PATH additions.
PATH=\"$DOTFILES_BIN_DIR:\$PATH\"
export PATH

# fzf configs

export FZF_IGNORES=Applications,Library,Movies,Music,Pictures,Qt,node_modules,venv,.DS_Store,.Trash,.cache,.git,.mypy_cache,.npm,.pyenv,.pytest_cache,.stack,.temp,__pycache__
export FZF_DEFAULT_COMMAND='command fd --hidden --no-ignore --exclude "{$FZF_IGNORES}" .'
export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
export FZF_ALT_C_COMMAND='command fd --type d --type l --hidden --no-ignore --exclude "{$FZF_IGNORES}" .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='**'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" \
        >> "$FILE_PATH"
   fi

    print_result $? "$FILE_PATH"

}

print_in_purple "\n • Create local bash config\n\n"

create_bash_local