#
# ~/.bashrc
#
# Mostly referenced: http://tldp.org/LDP/abs/html/sample-bashrc.html

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#-------------- Source Any Global Definitions ------------------------------{{{1

if [ -f /etc/bashrc ]; then
  . /etc/bashrc   # --> Source /etc/bashrc, if present.
fi

#-------------- Path -------------------------------------------------------{{{1

# add ~/bin to the path
PATH=$PATH:$HOME/bin

#-------------- ENVIRONMENTAL VARIABLES ------------------------------------{{{1

export EDITOR=vim # TODO there are other svneditor,giteditor,visual, etc

#-------------- Colors -----------------------------------------------------{{{1
# These are ANSI escape sequences to change the color of the terminal window.
# See https://en.wikipedia.org/wiki/ANSI_escape_code for reference
# There are only a handful of colors listed below
# Use `echo -e` to interpret escape sequences

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

# echo -e '\E[38;2;255;0;0mThis is red' # foreground
# echo -e '\E[48;2;255;0;0mThis is red\033[0m' # background

#-------------- Aliases ----------------------------------------------------{{{1

alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias which='type -a'

alias ..='cd ..'
alias ...='cd ../..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# du/df
alias d1='du -kh --max-depth=0'
alias du='du -kh'
alias df='df -kTh'

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color=auto'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.

# tree
alias tree='tree -C'

# vim
alias vi='vim'

#grep
alias grep='grep --color=auto'

#-------------- Prompt -----------------------------------------------------{{{1
# TODO document the format of PS1 that I used

# get a colored string for the hostname if connected to a remote machine
if [ -n "${SSH_CONNECTION}" ]; then # Connected on remote machine, via ssh
  PS1_host=${BGreen}
elif [[ "${DISPLAY%%:0*}" != "" ]]; then # Connected on remote machine, not ssh
  PS1_host=${SALERT}
else # Connected on local machine.
  PS1_host=
fi

if [ -n "$PS1_host" ]; then
  PS1_host="@\[$PS1_host\]\h\[$NC\] "
fi

# get a colored string for the logged in user name. Empty string if not SSHed or
# SUed as someone else.
if [[ ${USER} == "root" ]]; then # User is root.
  PS1_user=${ALERT}
elif [[ ${USER} != $(logname) ]]; then # User is not login user.
  PS1_user=${BRed}
elif [ -n "$PS1_host" ]; then # we are connected to a remote computer
  PS1_user=${BGreen}
else
  PS1_user=
fi

if [ -n "$PS1_user" ]; then
  PS1_user="\[$PS1_user\]\u\[$NC\]"

  if [ -z ${PS1_host} ]; then # if no host, then append a space
    echo "here"
    PS1_user="$PS1_user "
  fi
fi

PS1_dir="\[${BGreen}\]\$(shortenPath)>\[$NC\] "

# putting it all together
PS1="$PS1_user$PS1_host$PS1_dir"

# TODO PROMPT_COMMAND


#-------------- Extra Stuff ------------------------------------------------{{{1
# source the bash file that is not saved in the .dotfiles repo
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
