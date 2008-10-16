#!/bin/bash

stream=mms://www.fixtv.hu/fixdsl
tmp=/home/gabor/tmp/lxp.avi
video=/home/gabor/Videók/lxp/linuxportal_$TDAY.avi

lxp_play_stream()
{
    /usr/bin/mplayer -cache 3000 $stream
}

lxp_capture_stream()
{
    /usr/bin/mplayer -cache 5000 -dumpfile $tmp -dumpstream $stream
}

lxp_convert_stream()
{
    # Option -ofps needed to can be run by xine
    /usr/bin/mencoder $tmp -ofps 30 -oac mp3lame -ovc copy -o $video
}

export -f lxp_play_stream
export -f lxp_capture_stream
export -f lxp_convert_stream
