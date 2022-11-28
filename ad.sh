#!/bin/bash
python3 -m pip install -r requirements.txt
# WINDOWS SERVER SETUP
# Setup winrm on host
ansible-playbook -vvv playbooks/win-init.yml -i config/inventory.yml 

# Rename Windows Server box
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml

# Setup AD Domain
ansible-playbook -vvv playbooks/ad-domain.yml -i config/inventory.yml -e @config/ad_domain.config.yaml

# AD User Templating
ADBOOK=./playbooks/ad-users.yml
if [ -f $ADBOOK ]; then
    rm $ADBOOK
fi
jinja2 jinja_templates/ad-users.j2 config/ad_domain.config.yaml  >> $ADBOOK
ansible-playbook -vvv playbooks/ad-users.yml -i config/inventory.yml 