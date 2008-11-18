#!/bin/bash

autocrop()
{

    usage()
    {
        echo "Automatically crop an image to a rectangle that throws away unused alpha space."
        echo "Usage: `basename $0` file"
    }

    if [ $# -lt 1 ] ; then
        usage
        return 1
    fi

    input=$1
    suffix="_n"
    output=${input%.*}$suffix.${input##*.}

    convert $input -trim +repage $output

}

export -f autocrop
