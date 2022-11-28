#!/bin/bash
python3 -m pip install -r requirements.txt

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