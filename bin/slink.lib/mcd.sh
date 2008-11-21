#!/bin/bash

mcd () {
    usage()
    {
        echo "Create directory if not exists already, and change to it."
        echo "Usage: `basename $0` directory"
    }

    if [ $# -lt 1 ] ; then
        usage
        return 1
    fi
    if [ "$1" = "" ] ; then
        cd
    else
        if [ ! -d "$1" ] ; then
            mkdir $1
        fi
        cd $1
    fi
}

export -f mcd
