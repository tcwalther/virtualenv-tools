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
    echo "Creating virtualenv..."
    out=$(virtualenv $1 --system-site-packages 2>&1)
    # only proceed if virtualenv was created
    if [ -f ~/.virtualenvs/$1/bin/activate ]
    then
        echo "Installing newest pip and ipython..."
        out=$(source ./activate-env.sh $1 2>&1) && \
        out=$(easy_install -U setuptools 2>&1) && \
        out=$(pip install ipython 2>&1) && \
        echo 'Done.' || (echo 'Error when installing. Check the output:' && echo $out)
    else
        echo "Error creating the virtualenv. Check the output:"
        echo $out
    fi
fi
