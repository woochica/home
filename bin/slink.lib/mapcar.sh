#!/bin/bash

mapcar() {
    usage()
    {
        echo "Run a command on each file matches against file mask."
        echo "Usage: `basename $0` command filemask"
    }

    if [ $# -lt 1 ] ; then
        usage
        return 1
    fi

    command=$1
    shift 1
    for file in $@ ; do
        eval $command $file
    done
}

export -f mapcar
