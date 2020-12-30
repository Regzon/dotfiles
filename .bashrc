# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

generate_words() {
  # Random Word Generator

  if [ $# -ne 1 ]
  then
  echo "Please specify how many random words would you like to generate !" 1>&2
  echo "example: generate_words 3" 1>&2
  echo "This will generate 3 random words" 1>&2
  exit 0
  fi

  # Constants
  X=0
  ALL_NON_RANDOM_WORDS=/usr/share/dict/words

  # total number of non-random words available
  non_random_words=`cat "$ALL_NON_RANDOM_WORDS" | wc -l`

  # while loop to generate random words
  # number of random generated words depends on supplied argument
  while [ "$X" -lt "$1" ]
  do
  random_number=`od -N3 -An -i /dev/urandom |
  awk -v f=0 -v r="$non_random_words" '{printf "%i\n", f + r * $1 / 16777216}'`
  sed `echo $random_number`"q;d" $ALL_NON_RANDOM_WORDS
    let "X = X + 1"
  done
}

docker-connect() {
  if [ "$DOCKER_CONNECT_PID" ]; then
    kill "$DOCKER_CONNECT_PID"
    echo "Killed old session at $DOCKER_HOST_DISPLAY"
    _docker-connect-cleanup
  fi
  DOCKER_HOST_DISPLAY="$1"
  sh -c "ssh -o ExitOnForwardFailure=yes -L /tmp/docker-connect-\$\$.sock:/var/run/docker.sock \"$1\" -NT" &
  DOCKER_CONNECT_PID=$!
  export DOCKER_HOST="unix:///tmp/docker-connect-$DOCKER_CONNECT_PID.sock"
  trap "kill -0 $DOCKER_CONNECT_PID &>/dev/null || _docker-connect-cleanup" SIGCHLD
}

# Cleanup for docker-connect
_docker-connect-cleanup() {
  rm ${DOCKER_HOST##*://} &>/dev/null
  unset DOCKER_HOST DOCKER_HOST_DISPLAY DOCKER_CONNECT_PID
}

# Upate path with sbin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/local/sbin

# Upate path with local bin
export PATH=$PATH:$HOME/.local/bin

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Workspaces/go

# Rust
export PATH=$PATH:$HOME/.cargo/bin

source $(rustc --print sysroot)/etc/bash_completion.d/cargo

# Define colored diff
diff() {
    tmppipe=$(mktemp)
    chmod 600 $tmppipe
    env diff -u --color=always "$@" > $tmppipe
    [ $? != 2 ] && cat $tmppipe | less -R
    rm $tmppipe
}

# Set vi mode
set -o vi

# Virtualenv configuration
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Workspaces
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
source $HOME/.local/bin/virtualenvwrapper.sh

# Local npm configuration
export npm_config_prefix=$HOME/.local

alias ll='ls -lh --color'

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
