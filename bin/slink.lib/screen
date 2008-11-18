#!/bin/bash

# Attach or start new screen session
screen_start_or_open()
{
    if [ `screen -list | wc -l` -gt 2 ] ; then
        if [ `echo $TERMCAP | grep screen | wc -l` -eq 0 ] ; then
            screen -rx
        fi
    else
        screen
    fi;
}

export -f screen_start_or_open

