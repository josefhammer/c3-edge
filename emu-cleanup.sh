#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Run Provision Playbook
cd $DIR  # ansible.cfg is only read from the _current_ working directory
ansible-playbook emu.yml --extra-vars "emu_cleanup=true" "$@"
