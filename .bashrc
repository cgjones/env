# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Count and sum lines recursively
alias asmlinecount='find -type f | egrep "(\.asm|\.s|\.S)$" | xargs cat | wc -l'
alias cclinecount='find -type f | egrep "(\.c|\.cc|\.cpp|\.h)$" | xargs cat | wc -l'
alias jslinecount='find -type f | egrep "(\.js|\.js.in)$" | xargs cat | wc -l'

# A nice way to compartmentalize error messages
alias makeless='make 2>&1 | less'

# Always enable expressions for echo
alias echo='echo -e'

export PATH="/usr/local/bin:$PATH"

##-----------------------------------------------------------------------------
## Chromium junk
export PATH=$PATH:~/src/depot_tools

##-----------------------------------------------------------------------------
## Windows cross-compiler toolchain
export PATH=~/xbin:$PATH

##-----------------------------------------------------------------------------
## valgrind
export PATH=~/usr/lib/valgrind:$PATH

# Supply a branch name to eat and update on top of.  For example,
#
#  $ # merge branch 'foo' into upstream
#  $ eatbranch foo
#
alias eatbranch='git checkout master && git pull && git fetch upstream && git merge upstream/master && git branch -D '

# Add js.jar to the java classpath
export CLASSPATH="$CLASSPATH:$HOME/lib/java:$HOME/lib/java/js.jar"

# Extend ld search path
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

# Add home bin directories to path
export PATH="$HOME/sbin:$HOME/usr/bin:$PATH:$HOME/bin"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/android/sdk/platform-tools:$PATH"

## Needed by node-modules-cache?
export DISABLE_NODE_MODULES_CACHE=1

export NVM_DIR="/home/cjones/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

##-----------------------------------------------------------------------------
## git development: show current branch in prompt
##
PS1='\u@\h:\w[\[`git rev-parse --abbrev-ref HEAD 2>/dev/null`\]]\$ '
