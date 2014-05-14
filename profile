# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"
export BUNDLER_EDITOR=vi
export QWANDRY_EDITOR=vi

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export PATH=/usr/local/bin/npm:$PATH
export MONGODB_PATH=/usr/local/Cellar/mongodb/2.4.9/bin:$MONGODB_PATH
export PSQL = /usr/local/bin/psql:$PSQL

alias gvim='/usr/local/bin/mvim -g'
alias vi='/usr/local/bin/mvim'
alias mysqlstart='sudo mysqld_safe --skip-grant-tables'
alias mysqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'
alias myip='ifconfig |grep inet'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
source ~/.bashrc

