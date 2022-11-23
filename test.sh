PFSENSE_RELAY=./pfsense/relay.sh 
# Remove if file exists
if [ -f "$PFSENSE_RELAY" ]; then
    rm $PFSENSE_RELAY
fi
jinja2 jinja_templates/pfsense_relay.j2 ./config/dhcp.config.yaml >> $PFSENSE_RELAY
ansible-playbook -vvv playbooks/pfsense.yml -i config/inventory.yml