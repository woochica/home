#!/bin/bash

fillcolor()
{
    usage()
    {
        echo "Set solid background color for transparent image."
        echo "Usage: `basename $0` -c rgbhex file"
    }

    if [ $# -lt 2 ] ; then
        usage
        return 1
    fi

    color=""
    
    while getopts "c:" opt
    do
        case $opt in
            c) color=$OPTARG;;
            \?) usage;;
        esac
    done
    shift $(($OPTIND - 1))

    if [ -z $1 ]; then
        usage
        return 1
    fi

    input=$1
    extension="jpg"
    output=${input%.*}.$extension

    convert $input -background "#$color" -flatten $output
}

export -f fillcolor
