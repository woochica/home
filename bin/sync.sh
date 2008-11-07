#!/bin/env zsh

rsync -a /home/gabor /media/slinkpassport/slink6400                         ~

exit 0;

###############################################################################
# CONFIGURATION
###############################################################################

tday=$(/bin/date +%Y%m%d)
yday=$(/bin/date -d yesterday +%Y%m%d)
remote_servers=(20y.hu
                192.168.1.103)
weekly_dirs=(/home/gabor/bkp)
seasonal_dirs=(/home/gabor/Desktop/MyDocuments
               /home/gabor/Desktop/MusicLibrary
               /home/gabor/Desktop/Olvasatlan)
mail=`which mail`
bzr=`which bzr`
zip=`which bzip2`

###############################################################################
# LOCAL BACKUP
###############################################################################

# Daily routines
daily() {
    # Query bzr diff since yesterday
    diff_file=/tmp/bzr_slink6400_${tday}.diff
    $bzr diff -r date:yesterday..date:today | $zip > $diff_file
    # Mail diff to GMail box under label "bkp"
    $mail -s "bzr diff on slink6400 for ${tday}" "gabor+bkp@20y.hu"
    # Run bzr update on remote servers
    ## FIXME ##
    return
}

# Weekly
weekly() {
    ## FIXME ##
    return
}

# Seasonal
seasonal() {
    ## FIXME ##
    return
}

###############################################################################
# REMOTE BACKUP
###############################################################################

# blogomat rsync-elni localba
# sqlt dumpolni es rsyncelni localba
## FIXME ##

###############################################################################
# MAIN
###############################################################################

daily()
weekly()
seasonal()
