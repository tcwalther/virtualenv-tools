#!/bin/bash

export PIP_CONFIG_FILE="$HOME/.pip/pip.conf"
cd ~/.virtualenvs
if [ -f ~/.virtualenvs/$1/bin/activate ]
then
    echo "The virtualenv $1 already exists."
elif [ $1 == '.git' ]
then
    echo "Invalid name for a virtualenv. Are you actively trying to break the system?"
else
    echo "Creating virtualenv $1..."

    # check for --no-site-packages
    flags="--system-site-packages"
    if [[ "$@" =~ "--no-site-packages" ]]
    then
        flags=""
    fi
    out=$(virtualenv $* $flags 2>&1)
    if [ ! $? ]  # check if return status was not 0
    then
        printf "Error creating the virtualenv. Check the output:\n\n$out\n"
    elif [ -f ~/.virtualenvs/$1/bin/activate ]  # only proceed if virtualenv was created
    then
        echo "Installing newest pip and ipython..."
        out=$(source ./activate-env.sh $1 2>&1 && \
              easy_install -U setuptools 2>&1 && \
              pip install ipython 2>&1) && \
        echo 'Done.' || printf "Error when installing. Check the output:\n\n$out\n"
    else  # probably --help was passed, let's print the output
        printf "$out\n"
    fi
fi
