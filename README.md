# Ansible and Terraform Lab Setup
Be sure that OpenSSH is enabled on ur windoze box!

Windows needs to have a static IP and SSH Server setup.
Denote this in your DHCP Setup.

Make sure that the following is installed
* Ansible
* Ansible-Lint
* Python3 (and pip)

Example ansible run:
```
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml
```