#!/bin/bash
dnf list all | grep python
dnf install python3.12-pip.noarch -y
pip3.12 install botocore boto3 -y
dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/sriharsha6197/expense-ansible.git -e ansible_user=centos -e ansible_password=DevOps321 -e role_name=${server_component}