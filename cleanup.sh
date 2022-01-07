#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $# -eq 0 ]
  then
    echo "Usage: $0 <playbook>"
    echo ""
    exit 1
fi

PLAYBOOK=$1
shift

# Run Provision Playbook
cd $DIR  # ansible.cfg is only read from the _current_ working directory
ansible-playbook "$PLAYBOOK" --extra-vars "cleanup=true" "$@"
