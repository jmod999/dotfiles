echo 'Processing ~/.bashrc file'
# this is a testing comment 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Added following line for autotest with Cucumber and RSpec
export AUTOFEATURE=true
export RSPEC=true

# Added following line for BUNDLER editor.
export BUNDLER_EDITOR=vim
export EDITOR=vim

#### PS1 customization ####
NONE="\[\033[0m\]"    # unsets color to term fg color

# regular colors
K="\[\033[0;30m\]"    # black
R="\[\033[0;31m\]"    # red
G="\[\033[0;32m\]"    # green
Y="\[\033[0;33m\]"    # yellow
B="\[\033[0;34m\]"    # blue
M="\[\033[0;35m\]"    # magenta
C="\[\033[0;36m\]"    # cyan
W="\[\033[0;37m\]"    # white

# emphasized (bolded) colors
EMK="\[\033[1;30m\]"
EMR="\[\033[1;31m\]"
EMG="\[\033[1;32m\]"
EMY="\[\033[1;33m\]"
EMB="\[\033[1;34m\]"
EMM="\[\033[1;35m\]"
EMC="\[\033[1;36m\]"
EMW="\[\033[1;37m\]"

# background colors
BGK="\[\033[40m\]"
BGR="\[\033[41m\]"
BGG="\[\033[42m\]"
BGY="\[\033[43m\]"
BGB="\[\033[44m\]"
BGM="\[\033[45m\]"
BGC="\[\033[46m\]"
BGW="\[\033[47m\]"

# displays only the last 50 characters of pwd
set_new_pwd() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=50
    # Indicate that there has been dir truncation
    local trunc_symbol="…"
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}
# Git tab completion
# source ~/bin/git-completion.bash
# the name of the git branch in the current directory
set_git_branch() {
    unset GIT_BRANCH
    local branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'`;

    if test $branch
        then
            GIT_BRANCH="${EMG}git:${NONE}$branch"
    fi
}

# revision of the svn repo in the current directory
set_svn_rev() {
    unset SVN_REV
    local rev=`svn info 2> /dev/null | grep "Revision" | sed 's/Revision: \(.*\)/r\1 /'`;

    if test $rev
        then
            SVN_REV="${EMG}svn:${NONE}$rev"
    fi
}

# the name of the activated virtual env
set_virtual_env_base() {
    unset VIRTUAL_ENV_BASE
    local venv=`basename "$VIRTUAL_ENV"`

    if test $venv
        then
            VIRTUAL_ENV_BASE="${EMG}env:${NONE}$venv "
    fi
}

# git aliases  (Also see end of file)
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias got='git '
alias get='git '
alias gap='git add --patch'
alias gmf='git merge --ff-only'
alias gpp='git pull --rebase && git push'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gvd='git difftool'
alias gl='git l'

# For less and ANSI color
alias rless='less -R'

# for Silver Search
alias agc='ag --color -C3'

# aliases for bash
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# for mac address manipulation
alias random_mac='sudo ifconfig eth0 ether `openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"`'
alias restore_mac='sudo ifconfig eth0 ether 00:15:c5:3e:81:9e'
alias mac_gen='openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"'

# For ssh-agent

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
    test_identities
    fi
# if $SSH_AGENT_PID is not properly set, we might be able to load one from
# $SSH_ENV
else
    if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" > /dev/null
    fi
    ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
        test_identities
    else
        start_agent
    fi
fi

# Don't record history for lines that start with a space
export HISTCONTROL=ignorespace

#Custom prompt

update_prompt() {
    set_new_pwd
    set_git_branch
    set_svn_rev
    set_virtual_env_base

    PS1="[\$(~/.rvm/bin/rvm-prompt)] ${GIT_BRANCH}${SVN_REV}${VIRTUAL_ENV_BASE}${B}\n${EMB}[${NONE}${NEW_PWD}${EMB}/]\n ${NONE}\$: "
}

# For Dropbox
# echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches

PROMPT_COMMAND=update_prompt

# for GPG
GPG_TTY=$(tty)
export GPG_TTY

# for vi bindings in shell
set -o vi

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

# added following line to force include of rvm settings  vhgiii
# PS1="[\$(~/.rvm/bin/rvm-prompt)]\n$PS1"

# Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting
# export PATH=$PATH:/usr/local/mongodb/bin # Add MongoDB
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

