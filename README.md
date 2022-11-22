# Ansible and Terraform Lab Setup
Be sure that OpenSSH is enabled on ur windoze box!

Make sure that the following is installed
* Ansible
* Ansible-Lint
* Python3 (and pip)

Example ansible run:
```
ansible-playbook -vvv playbooks/rename-winserve.yaml -i config/inventory.yml
```