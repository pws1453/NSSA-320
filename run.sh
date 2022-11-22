#!/bin/bash

# WINDOWS SERVER SETUP
# Setup winrm on host
ansible-playbook -vvv playbooks/win-init.yml -i config/inventory.yml 
# Rename Windows Server box
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml
# Setup AD Domain
ansible-playbook -vvv playbooks/ad-domain.yml -i config/inventory.yml -e @config/ad_domain.config.yaml
# AD User Templating
# jinja2 jinja_templates/ad-users.j2 config/ad_domain.config.yaml >> playbooks/ad-users.yml

# DHCP Templating <3
DHCPJINJA=./scripts/DHCPServer-Setup.ps1
# Remove if file exists
if [ -f "$DHCPJINJA" ]; then
    rm $DHCPJINJA
fi
jinja2 $DHCPJINJA ./config/dhcp.config.yaml >> ./scripts/DHCPServer-Setup.ps1
# Setup DHCP
ansible-playbook -vvv playbooks/win-dhcp.yml -i config/inventory.yml 