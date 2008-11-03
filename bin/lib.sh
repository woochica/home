#!/bin/bash

# Create directory if not exists already, and change to it
mcd () {
    if [ "$1" = "" ] ; then
        cd
    else
        if [ ! -d "$1" ] ; then
            mkdir $1
        fi
        cd $1
    fi
}

# Run a command on each file matches against file mask
mapcar() {
    command=$1
    shift 1
    for file in $@ ; do
        eval $command $file
    done
}

export -f mcd
export -f mapcar
