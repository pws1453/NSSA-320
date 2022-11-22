#!/bin/bash
jinja2 jinja_templates/Set-DHCPServer.j2 dhcp.config.yaml >> ./playbooks/scripts/DHCPServer-Setup.ps1
