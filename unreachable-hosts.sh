#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR
echo Pinging all hosts ... please wait.
echo
ansible -m ping all 2>&1 | grep UNREACHABLE | sort
