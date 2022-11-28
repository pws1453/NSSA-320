#!/bin/bash
python3 -m pip install -r requirements.txt

# Setup FreeIPA
ansible-playbook -vvv playbooks/ipa-preconfig.yml -i config/inventory.yml 
ansible-playbook -vvv playbooks/ipa.yml -i config/inventory.yml 
ansible-playbook -vvv playbooks/ipa-users.yml -i config/inventory.yml

# Setup Rochester Apex
ansible-playbook -vvv playbooks/get-fonts.yml -i config/inventory.yml
ansible-playbook -vvv playbooks/push-fonts.yml -i config/inventory.yml
ansible-playbook -vvv playbooks/roc-apex.yml -i config/inventory.yml