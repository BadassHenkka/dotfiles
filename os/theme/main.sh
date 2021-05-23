#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

main() {

	# Setup PopOS theming
	./pop_os.sh

	echo "
      		Configure the above settings manually and select
        	number 1 to continue

        	Exit will leave you with a bunch of unfinished business...
	"

	# Wait until manual settings have been configured

	select yn in "continue" "exit"; do
    		case $yn in
        		continue ) ./terminal_theme.sh; break;;
		        exit ) exit;;
    		esac
	done

}

main
