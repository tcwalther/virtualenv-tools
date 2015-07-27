#!/bin/bash

export PIP_CONFIG_FILE="$HOME/.pip/pip.conf"
if [ -d ~/.virtualenvs/$1 ]
then
    . ~/.virtualenvs/$1/bin/activate
else
    echo "virtualenv $1 doesn't exist."
fi
