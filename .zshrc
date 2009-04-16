. ~/bin/reusable_libs.sh > /dev/null

include "slink"

setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt PRINT_EIGHT_BIT
setopt AUTO_CD
setopt CORRECT
setopt IGNORE_EOF
unsetopt HUP

alias ls='/bin/ls -hal --color'
alias ls1='/bin/ls -1'
alias ec='emacsclient -c'
alias cp='cp -v'
alias rm='rm -vi'
alias top='top -U `id -u`'
alias muti='identify'

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zshhistory
TERM=xterm
PS1='%{[36m%}#%{[0m%} '
RPS1='%{[32m%}%~%{[0m%}'
export PYTHONPATH=$PYTHONPATH:/home/gabor/dev/python
export EDITOR="emacsclient -t"
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

if [ "$DESKTOP_SESSION" = "kde" ] ; then
    alias eog=gwenview
    alias nautilus=dolphin
fi

screen_start_or_open
