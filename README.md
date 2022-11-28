# Ansible and Terraform Lab Setup
Be sure that OpenSSH is enabled on ur windoze box!

All devices need to have a static IP and SSH Server setup, and have root/Administrator access availible over SSH.
Windows Domain Controller must have it's static IP in your dhcp.config.yaml and inventory.yml.
PFSense's OPT1 interface must also have it's firewall rules set in the GUI. 

Make sure that the following is installed
* Ansible
* Ansible-Lint
* ansible-freeipa
* Python3 (and pip)

Example ansible run:
```
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml
```