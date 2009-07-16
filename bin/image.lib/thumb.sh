#!/bin/zsh

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
    output=$base$suffix"."$extension

    # Set image processing args
    if [ ! -z "$dim" ] ; then
        flags="-resize $dim"
    fi

    # Only resize image if original image was larger then given dimension,
    # otherwise simply copy.
    original_dim=`identify $input | cut -d " " -f 3`
    if [ "$dim[1]" = "x" ] ; then
        # check height
        original_dim=`echo $original_dim | cut -d "x" -f 2`
        if [ $original_dim -lt $dim[2,-1] ] ; then
            flags=""
        fi
    else
        # check width
        original_dim=`echo $original_dim | cut -d "x" -f 1`
        if [ $original_dim -lt $dim ] ; then
            flags=""
        fi
    fi

    eval $convert $flags $input $output
}

export -f thumb
