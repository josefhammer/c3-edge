#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR
ansible nodes:jetsons -a "shutdown -h now" --become "$@"
sudo shutdown -h now
