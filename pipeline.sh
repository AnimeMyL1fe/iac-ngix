#!/bin/bash

#---------------------------
# VARIBLES
#---------------------------
workdir="$HOME/yandex_prac"


path_terraform_instance="$workdir/terraform/yandex_instance/"
path_terraform_networks="$workdir/terraform/yandex_networks/"

path_ansible_dir="$workdir/ansible/"



function terraform_apply {
    cd $path_terraform_networks
    terraform apply
    cd $path_terraform_instance
    terraform apply
}

function terraform_destroy {
    cd $path_terraform_instance
    terraform destroy
    cd $path_terraform_networks
    terraform destroy
}

function ansible_deploy {
    cd $path_ansible_dir
    ansible-playbook playbook.yaml
}


#----------------------------
# MAIN
#----------------------------
source yandex_export.sh

read -p "Введите: apply/destroy " input

if [[ "$input" == "apply" ]]; then
    terraform_apply
    echo "10 сек пауза для ssh"
    sleep 10
    ansible_deploy
else
    terraform_destroy
fi