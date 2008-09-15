#!/bin/zsh

GIT_REPOS=("/home/gabor/dev/webma/" "/home/gabor/")

# GNOME keyring daemon doesn't read SSH config for the proper key path
killall gnome-keyring-daemon 

for ((i = 1; i <= $#GIT_REPOS; i++ )) {
    cd $GIT_REPOS[$i]
    nr=`git diff --raw | wc -l`
    if [ $nr -eq 0 ]; then
        echo Pushing commits from $GIT_REPOS[$i].
        git push
    else
        echo $nr uncommited changes in $GIT_REPOS[$i].
    fi
    cd -
}
