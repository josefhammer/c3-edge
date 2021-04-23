#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "** Change Gateway Password (leave current password blank if changed already):"
passwd

# Install Ansible via PIP3 (only old version available via apt on Raspberry Pi)
sudo apt -y update
sudo apt -y install python3-pip
sudo pip3 install ansible

pushd $DIR  # ansible.cfg is only read from the _current_ working directory

# Set the right inventory file (symlink)
if [ ! -s hosts.yml ]; then
    if [ `uname -m` == 'x86_64' ]; then
        ln -sf hosts-aau.yml hosts.yml
    else
        ln -sf hosts-jh.yml hosts.yml
    fi
fi

# Run Bootstrap Playbooks
ansible-playbook --timeout 30 bootstrap.yml   # higher timeout due to changes to hostname ("Timeout (12s) waiting for privilege escalation prompt")
popd
