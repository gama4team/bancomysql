cd 1-ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts access.yml -u ubuntu --private-key /var/lib/jenkins/.ssh/id_rsa
