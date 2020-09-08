#!/usr/bin/env bash

# File:
#     installf.sh
#
# Author:
#     Jaime Señor
#
# Description:
#     This script checks for the existance of certain programs and tries to
#     install them if needed. It is designed to complete a clean Linux install,
#     adding some software that is usually needed for basic development and
#     other stuff.

NUM_ERRORS=0

function checkprogram {
  echo -n "[*] Checking $1... "

  if which $1 > /dev/null; then
    echo "OK"
  else
    echo "NOT FOUND"
    echo -n "    Installing... "

    if apt-get install -y $2 > /dev/null; then
      echo "OK"
    else
      echo "ERROR"
      NUM_ERRORS=$[ $NUM_ERRORS + 1 ]
    fi
  fi
}

# Check that we are root
if [ $(id -u) -ne 0 ]; then
  echo This command needs to be run as root
  exit
fi

# Update repositories
apt-get update > /dev/null

# git
checkprogram git git

# gcc, g++, make, etc...
checkprogram gcc build-essential

# ifconfig
checkprogram ifconfig net-tools
