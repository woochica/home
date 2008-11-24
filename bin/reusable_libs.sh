#!/bin/bash

load_library_script()
{
    script=$1
    echo "Loading script \"$script\"..."
    . $script > /dev/null
}

include()
{

    usage()
    {
        echo "Loads scripts in a library."
        echo "Usage: `basename $0` \"library\""
        echo "       `basename $0` \"library.*\""
        echo "       `basename $0` \"library.script\""
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
        if [ `ps | grep `echo $$` | awk '{ print $4 }'` = "zsh" ] ; then
            for script in $library_dir/$~pattern.sh; do
                load_library_script $script
            done
        # Bash way
        else
            for script in $library_dir/$pattern.sh; do
                load_library_script $script
            done
        fi
    # Load meta library
    elif [ -f "${library_dir}.sh" ] ; then
        load_library_script "${library_dir}.sh"
    else
        echo $library_dir": No such library found"
    fi
}

export -f include
