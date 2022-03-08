#
# ~/.bashrc
#
# Mostly referenced: http://tldp.org/LDP/abs/html/sample-bashrc.html
#    and from Ubuntu
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#-------------- Source Any Global Definitions ------------------------------{{{1

if [ -f /etc/bashrc ]; then
  . /etc/bashrc   # --> Source /etc/bashrc, if present.
fi

#-------------- HISTORY ---------------------------------------------------
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#-------------- Shell Options ----------------------------------------------
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

#------------- Bash Completion --------------------------------------------
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#------------- Less Pipe ---------------------------------------------------
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# from Ubuntu
## enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    #alias dir='dir --color=auto'
#    #alias vdir='vdir --color=auto'
#
#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi
#
## colored GCC warnings and errors
##export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


#-------------- Prompt -----------------------------------------------------{{{1
# TODO document the format of PS1 that I used

# get a colored string for the hostname if connected to a remote machine
if [ -n "${SSH_CONNECTION}" ]; then # Connected on remote machine, via ssh
  PS1_host=${BBlue}
elif [[ "${DISPLAY%%:0*}" != "" ]]; then # Connected on remote machine, not ssh
  PS1_host=${SALERT}
else # Connected on local machine.
  PS1_host=
fi

if [ -n "$PS1_host" ]; then
  PS1_host="\[$BBlue\]@\[$PS1_host\]\h\[$NC\] "
fi

# get a colored string for the logged in user name. Empty string if not SSHed or
# SUed as someone else.
if [[ ${USER} == "root" ]]; then # User is root.
  PS1_user=${ALERT}
elif [[ ${USER} != $(logname) ]]; then # User is not login user.
  PS1_user=${BRed}
elif [ -n "$PS1_host" ]; then # we are connected to a remote computer
  PS1_user=${BBlue}
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

PS1_dir="\[${BGreen}\]\$(shortenPath)\[$NC\] "

# putting it all together
PS1="$PS1_user$PS1_host$PS1_dir"

# from Ubuntu
## set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi
#
## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac
#
## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
##force_color_prompt=yes
#
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi
#
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt
#
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# TODO PROMPT_COMMAND

#-------------- Extra Stuff ------------------------------------------------{{{1
# source the bash file that is not saved in the .dotfiles repo
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
