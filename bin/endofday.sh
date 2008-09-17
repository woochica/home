#!/bin/zsh

GIT_REPOS=("/home/gabor/dev/webma/" "/home/gabor/slink/" "/home/gabor/")

# GNOME keyring daemon doesn't read SSH config for the proper key path
if [ `/sbin/pidof gnome-keyring-daemon | wc -c` -gt 1 ] ; then
    killall gnome-keyring-daemon
fi

for ((i = 1; i <= $#GIT_REPOS; i++ )) {
    cd $GIT_REPOS[$i]
    nr=`git diff --raw | wc -l`
    if [ $nr -eq 0 ]; then
        echo Pushing commits from $GIT_REPOS[$i].
        git push
    else
        echo $nr uncommited changes in $GIT_REPOS[$i].
        echo "Commit first? (y/n) "
        read yes_or_no
        if [ "${yes_or_no}" = "n" ] ; then
            git push
        fi
    fi
    cd -
}
