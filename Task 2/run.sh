#!/bin/bash
#this script runs ansible playbook to install and configure nginx

ansible-playbook nginx_install.yml
ansible-playbook nginx_config.yml 