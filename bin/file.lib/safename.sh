#!/bin/sh

asciiname() {
    if [ -z "$1" ]; then
        echo "A parameterkent atadott allomanynevbol kiveszi a nem ASCII karaktereket."
        echo "A szokozoket atkonvertalja alahuzasokra."
        echo "Hasznalat: `basename $0` allomanynev\n"
        return 1
    fi;

    acname=`basename "$1"`
    dirname=`dirname "$1"`

    aaname=`echo $acname | sed -e "s/á/a/g" \
        -e "s/é/e/g" \
        -e "s/í/i/g" \
        -e "s/ó/o/g" \
        -e "s/ö/o/g" \
        -e "s/ő/o/g" \
        -e "s/ú/u/g" \
        -e "s/ü/u/g" \
        -e "s/ű/u/g" \
        -e "s/Á/A/g" \
        -e "s/É/E/g" \
        -e "s/Í/I/g" \
        -e "s/Ó/O/g" \
        -e "s/Ö/O/g" \
        -e "s/Ő/O/g" \
        -e "s/Ú/U/g" \
        -e "s/Ü/U/g" \
        -e "s/Ű/U/g" \
        -e "s/ï/o/" \
        -e "s/,//g" \
        -e "s/(//g" \
        -e "s/)//g" \
        -e "s/\\[//g" \
        -e "s/]//g" \
        -e "s/+/p/g" \
        -e "s/\!//g" \
        -e "s/@//g" \
        -e "s/~/_/g" \
        -e "s/\\.\\+/./g" \
        -e "s/?//g" \
        -e "s/ /_/g"`
    asname=`echo $aaname | tr "[:upper:]" "[:lower:]"`

    echo "$dirname/$asname"

}

safename() {

    if [ "$1" = "-h" -o "$1" = "--help" -o -z "$1" ]; then
        echo "Usage: `basename $0` dir|filename"
        echo "Strips illegal characters from the given filename and renames it."
        return 1
    fi;

    filename=$1

    # If the given filename is a file/directory
    if [ -e "$filename" ]; then
        # Strips illegal characters
        safename=`asciiname "$filename"`
        # Rename filename to safe version only if they differ
        if [ ! "$filename" = "$safename" ]; then
            echo Renaming "$filename" to "$safename"...
            mv "$filename" "$safename"
        fi;
        # Removes optional execute mode from files
        if [ -x "$safename" -a -f "$safename" ]; then
            chmod -x "$safename"
        fi;
    fi;

}

export -f safename
