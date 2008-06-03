# Create directory if not exists already, and change to it
mcd ()
{
    if [ "$1" = "" ]; then
        cd
    else
        if [ ! -d "$1" ]; then
            mkdir $1
        fi
        cd $1
    fi
}

#Run a command on each file matches against file mask
mapcar() { command=$1; shift 1; for file in $@; do eval $command $file; done }

setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt PRINT_EIGHT_BIT
setopt AUTO_CD
setopt CORRECT
setopt IGNORE_EOF
unsetopt HUP

#bindkey -r "^D"
#bindkey "^D" list-choices

alias ls='/bin/ls -hal --color'
alias ls1='/bin/ls -1'
alias ec='emacsclient -c'
alias cp='cp -v'
alias rm='rm -vi'
alias top='top -U `id -u`'
alias muti='identify'
alias Terminal='Terminal --geometry=120x40'
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zshhistory
TERM=xterm
PS1='%{[36m%}#%{[0m%} '
RPS1='%{[32m%}%~%{[0m%}'
export PYTHONPATH=$PYTHONPATH:/usr/lib/gimp/2.0/python:/usr/lib/python2.5/site-packages/
export EDITOR=emacs
export TDAY=`date +%Y%m%d`
export YDAY=`date -d yesterday +%Y%m%d`
export PAGER=most

compctl -g '*.java' + -g '*(-/)' javac

autoload -U zsh-mime-setup
zsh-mime-setup 

alias -s sxw=oowriter
alias -s doc=oowriter
alias -s xls=oocalc
alias -s psd=gimp-remote

#Attach or start new screen session
screen_start_or_open() {
    if [ `screen -list | wc -l` -gt 2 ] ; then
        if [ `echo $TERMCAP | grep screen | wc -l` -eq 0 ] ; then
            screen -rx
        fi
    else
        screen
    fi;
}
