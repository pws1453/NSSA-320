#!/bin/bash
# DHCP Templating <3
jinja2 jinja_templates/Set-DHCPServer.j2 dhcp.config.yaml >> ./playbooks/scripts/DHCPServer-Setup.ps1
# Setup winrm on host
ansible-playbook -vvv playbooks/win-init.yml -i config/inventory.yml 
# Rename Windows Server box
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml
# Setup domain controller
ansible-playbook -vvv playbooks/ad-domain.yml -i config/inventory.yml -e @config/ad_domains.config.yaml