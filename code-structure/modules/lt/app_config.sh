#!/bin/bash
dnf list all | grep python | tee -a /opt/output.log
dnf install python3.12-pip.noarch -y | tee -a /opt/output.log
pip3.12 install botocore boto3 - | tee -a /opt/output.log
dnf install ansible -y | tee -a /opt/output.log
ansible-pull -i localhost, -U https://github.com/sriharsha6197/expense-ansible.git -e ansible_user=centos -e ansible_password=DevOps321 -e role_name=${server_component} | tee -a /opt/output.log