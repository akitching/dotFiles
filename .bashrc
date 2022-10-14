# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#CDPATH=".:~/FrequentDirectories"

export EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim
#export MPD_HOST="127.0.0.1"
export MPD_HOST="scratch@scratch.kitching.info"
export MPD_PORT="6600"
export GPG_TTY=$(tty)

export FIGNORE=.meta

export PATH=${PATH}:~/.local/bin

source ~/.bash_git

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

function :w () {
  echo "Ugh. You idiot, this is bash not vim."
}

function :q () {
  echo "Ugh. You idiot, this is bash not vim."
}

function :wq () {
  echo "Ugh. You idiot, this is bash not vim."
}

alias g='git'

#function prompt {
  # Check if superuser
#  if [ $(id -u) -eq 0 ]; then
#        # Yes. Set prompt borders to red
#        local BORDER="\[\033[01;31m\]"          # Red
#  else
#        # No. Set prompt borders to green
#        local BORDER="\[\033[32;1m\]"           # Green
#  fi
#  local STD_TEXT="\[\033[37;1m\]"               # White
#  local USERCOLOUR="\[\033[01;34m\]"                  # Blue
#  local HOST="\[\033[01;35m\]"                  # Purple
#  local WORKING_DIR="\[\033[01;33m\]"           # Yellow
#  local CMD_SUCCESS="\[\033[32;1m\]"            # Green
#  local CMD_FAILURE="\[\033[01;31m\]"           # Red
#  local INVISIBLE_TEXT="\[\033[0;30m\]"         # Black
#  local COL_TERMNAME="\[\033[01;36m\]"          # Cyan
#  local SPACING_BAR="\[\033[37;47m\]"           # White on White
#  local SPACING_BAR_SUCCESS="\[\033[32;42m\]"   # Green on Green
#  local SPACING_BAR_FAILURE="\[\033[31;41m\]"   # Red on Red
#  local NO_COLOR="\[\033[0m\]"

  if [ $(id -u) -eq 0 ]; then
        # Yes. Set prompt borders to red
        BORDER="\[\033[01;31m\]"          # Red
  else
        # No. Set prompt borders to green
        BORDER="\[\033[32;1m\]"           # Green
  fi
  STD_TEXT="\[\033[37;1m\]"               # White
  USERCOLOUR="\[\033[01;34m\]"                  # Blue
  HOSTCOLOUR="\[\033[01;35m\]"                  # Purple
  WORKING_DIR="\[\033[01;33m\]"           # Yellow
  CMD_SUCCESS="\[\033[32;1m\]"            # Green
  CMD_FAILURE="\[\033[01;31m\]"           # Red
  INVISIBLE_TEXT="\[\033[0;30m\]"         # Black
  COL_TERMNAME="\[\033[01;36m\]"          # Cyan
  SPACING_BAR="\[\033[37;47m\]"           # White on White
  SPACING_BAR_SUCCESS="\[\033[32;42m\]"   # Green on Green
  SPACING_BAR_FAILURE="\[\033[31;41m\]"   # Red on Red
  NO_COLOR="\[\033[0m\]"

  PS1="\
\n\
\`if [ \$? = 0 ]; then echo -en '${CMD_SUCCESS}'; else echo -en '${CMD_FAILURE}'; fi\`\
\$(s=\$(printf \"%*s\" \$COLUMNS); echo \${s// /_})\
${NO_COLOR}\
\[\033]0;\${TERMNAME} \$(pwd | grep Projects/ &>/dev/null; if [ \$? -eq 0 ]; then echo -en \$(pwd | awk -F'Projects/' '{print \$2}' | awk -F/ '{print \$1}'); fi) \u@\h:\w\007\]\
${BORDER}(${USERCOLOUR}\u${STD_TEXT}@${HOSTCOLOUR}\H${BORDER})\
-(${STD_TEXT}\$(date '+%F %T')${BORDER})\
\$(pwd | grep Projects/ &>/dev/null; if [ \$? -eq 0 ]; then echo -en \"${BORDER}-(${STD_TEXT}\" && \
echo -en \$(pwd | awk -F'Projects/' '{print \$2}' | awk -F/ '{print \$1}')\
&& echo -en \"${BORDER})\"; fi)"
PS1="${PS1}\$(git branch &>/dev/null; if [ \$? -eq 0 ]; then echo -en \"-(${USERCOLOUR}Git: ${WORKING_DIR}\" && echo -n \`__git_ps1\` | sed 's:(::' | sed 's:)::' && echo -en \"${BORDER})\""
PS1="${PS1}\$(git_status=\$(git status 2> /dev/null); if [[ ! \${git_status} =~ \"working directory clean\" ]]; then echo -en \"${CMD_FAILURE} ϟ\"; fi)"
PS1="${PS1}; fi)"
PS1="${PS1}\$(git_cherry=\$(git cherry -v origin/\$(echo \`__git_ps1\` | sed 's:(::' | sed 's:)::') 2> /dev/null); if [ \$? -eq 0 ]; then if [[ \${git_cherry} != \"\" ]]; then echo -en \"${CMD_FAILURE} ⟰\"; fi; fi)\n\
${BORDER}(${STD_TEXT}\
\$(/bin/ls -1A | /usr/bin/wc -l | sed 's: ::g') files${BORDER})-\
(${STD_TEXT}\$(/bin/ls -lah | grep -m 1 total | sed 's/total //')b\
${BORDER})"

PS1="${PS1}-(${WORKING_DIR}\
\$(pwd | grep Projects/ &>/dev/null; if [ \$? -eq 0 ]; then \
echo -en \"~~\"\$(pwd | awk -F'Projects/' '{print \$2}' | awk -F/ '{for(i=2;i<=NF;i++) {print \"/\"(\$i)}}') | sed -e 's: /:/:g'\
; else \
pwd | grep home/ &>/dev/null; \
if [ \$? -eq 0 ]; then \
echo -en \"~\"\$(pwd | awk -F'home/' '{print \$2}' | awk -F/ '{for(i=2;i<=NF;i++) {print \"/\"(\$i)}}') | sed -e 's: /:/:g'\
; else \
echo -en \`pwd\`\
; fi\
; fi)\
${BORDER})"

PS1="${PS1}\n${BORDER}(\
${STD_TEXT}\!\
${BORDER})\
${STD_TEXT} > ${NO_COLOR}"
  PS2="${INVISIBLE_TEXT} \! ${STD_TEXT} > ${NO_COLOR}"
  PS4='$0.$LINENO+ '
#}
#prompt

[ -s "/home/ak/.dnx/dnvm/dnvm.sh" ] && . "/home/ak/.dnx/dnvm/dnvm.sh" # Load dnvm
alias config='/usr/bin/git --git-dir=/home/ak/.cfg/ --work-tree=/home/ak'
