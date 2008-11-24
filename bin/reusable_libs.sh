#!/bin/bash

include()
{

    usage()
    {
        echo "Loads all scripts in a library."
        echo "Usage: `basename $0` \"library\""
    }
    
    if [ $# -lt 1 ] ; then
        usage
        return 1
    fi

    library="${1%.*}"
    pattern="${1##*.}"
    # If only library name was given, load all the scripts
    if [ "$pattern" = "$library" ] ; then
        pattern="*"
    fi
    library_dir=~/bin/$library.lib

    # Process scripts in library according to given pattern
    if [ -d $library_dir ] ; then
        # Zsh way
        if [ $pattern = "*" ] ; then
            for script in $library_dir/$~pattern.sh; do
                echo "Loading script \"$script\"..."
                . $script > /dev/null
            done
        # Bash way
        else
            for script in $library_dir/$pattern.sh; do
                echo "Loading script \"$script\"..."
                . $script > /dev/null
            done
        fi
    else
        echo $library_dir": No such library found"
    fi
}

export -f include
