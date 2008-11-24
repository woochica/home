#!/bin/bash

thumb() {
    usage()
    {
        echo "Generate thumbnail of image file."
        echo "Usage: `basename $0` [-w width | -h height] [-s suffix] [-e extension] file"
    }

    if [ $# -lt 1 ] ; then
        usage
        return 1
    fi

    convert=/usr/bin/convert
    basename=/bin/basename
    dim=""
    suffix=""
    extension=""

    while getopts "w:h:s:e:" opt
    do
        case $opt in
            w) dim=$OPTARG;;
            h) dim=x$OPTARG;;
            s) suffix=$OPTARG;;
            e) extension=$OPTARG;;
            \?) usage;;
        esac
    done

    shift $(($OPTIND - 1))

    if [ -z $1 ]; then
        usage
        return 1
    fi

    input=$1
    base=${input%.*}
    ext=${input##*.}
    if [ -z "$extension" ] ; then
        extension=$ext
    fi
    output=$base$suffix.$extension
    options=""
    if [ ! -z "$dim" ]; then
        options="-resize $dim"
    fi

    $convert $options $input $output
}

export -f thumb