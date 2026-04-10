-----------
Quick start

1. Настроить переменные в yandex_export.sh
2. source yandex_export.sh
3. sudo chmod +x pipeline.sh
4. ./pipeline.sh

* заранее подготовить S3 bucket 

-----------
varibles pipeline

workdir: директория проекта
path_terraform_instance: директория, с описанием тачек для  terraform
path_terraform_networks: директория, с описанием vps networks для terraforms
path_ansible_dir: директория ансибла

-----------
Structure

├── README.md
├── ansible
│   ├── ansible.cfg
│   ├── inventory
│   ├── playbook.yaml
│   └── roles
│       ├── bootstrap
│       │   ├── README.md
│       │   ├── files
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── tasks
│       │   │   └── main.yml
│       │   ├── templates
│       │   └── vars
│       │       └── main.yml
│       ├── proxy-nginx
│       │   ├── README.md
│       │   ├── files
│       │   ├── handlers
│       │   │   └── main.yml
│       │   ├── tasks
│       │   │   └── main.yml
│       │   └── templates
│       │       └── my-service.conf.j2
│       └── web-server-nginx
│           ├── README.md
│           ├── files
│           ├── handlers
│           │   └── main.yml
│           ├── tasks
│           │   └── main.yml
│           └── templates
│               └── index.html.j2
├── pipeline.sh
├── terraform
│   ├── yandex_instance
│   │   ├── ansible_inventory.tf
│   │   ├── data.tf
│   │   ├── output.tf
│   │   ├── provider.tf
│   │   ├── templates
│   │   │   └── hosts.yaml.tpl
│   │   ├── terraform.tfvars
│   │   ├── varibles.tf
│   │   └── vm.tf
│   └── yandex_networks
│       ├── outputs.tf
│       ├── provider.tf
│       ├── security_group.tf
│       ├── subnet.tf
│       └── varibles.tf
└── yandex_export.sh



-----------
Terraform

├── yandex_instance
│   ├── ansible_inventory.tf
│   ├── data.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── templates
│   │   └── hosts.yaml.tpl
│   ├── terraform.tfvars
│   ├── varibles.tf
│   └── vm.tf
└── yandex_networks
    ├── outputs.tf 
    ├── provider.tf
    ├── security_group.tf
    ├── subnet.tf
    └── varibles.tf

-
Краткое описание

yandex_instance: поднятия compute cloud инстансов
yandex_networks: поднятие облачной сети (subnet, security_group)


-----------
Хранение terraform.tfstate

.tfstate хранится в S3 bucket (Яндекс Object Storage)


-----------
Ansible

├── ansible.cfg
├── inventory
├── playbook.yaml
└── roles
    ├── bootstrap
    ├── proxy-nginx
    └── web-server-nginx

-
Краткое описание ролей

bootstrap:          установка пакетов
proxy-nginx:        установка и конфигурация проксирующего Nginx
web-server-nginx:   установка и конфигурация принимающего Nginx  
