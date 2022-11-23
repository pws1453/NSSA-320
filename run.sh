#!/bin/bash

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

# DHCP Templating <3
DHCPSCRIPT=./scripts/DHCPServer-Setup.ps1
# Remove if file exists
if [ -f "$DHCPSCRIPT" ]; then
    rm $DHCPSCRIPT
fi
jinja2 jinja_templates/Set-DHCPServer.j2 ./config/dhcp.config.yaml >> $DHCPSCRIPT
# Setup DHCP
ansible-playbook -vvv playbooks/win-dhcp.yml -i config/inventory.yml 

# Setup PFSense DHCP Relay
PFSENSE_RELAY=./pfsense/relay.sh 
# Remove if file exists
if [ -f "$PFSENSE_RELAY" ]; then
    rm $PFSENSE_RELAY
fi
jinja2 jinja_templates/pfsense_relay.j2 ./config/dhcp.config.yaml >> $PFSENSE_RELAY
ansible-playbook -vvv playbooks/pfsense.yml -i config/inventory.yml