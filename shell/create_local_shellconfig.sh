#!/bin/bash

declare DOT=$HOME/dotfiles

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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" \
        >> "$FILE_PATH"
   fi

    print_result $? "$FILE_PATH"

}

print_in_purple "\n • Create local bash config\n\n"

create_bash_local
