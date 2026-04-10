
yandex_prac_vm:
  children:
    prac:
      hosts: 
%{for name, vm in vms ~}
        ${name}: 
          ansible_host: ${vm.ip}
%{ endfor ~}

  vars: 
    ansible_user: ${ans_user}
    ansible_ssh_private_key_file: ${ans_ssh_key} 
    connection_protocol: ssh 
    
    # ansible_become: true #Становиться ли другим пользователем после подключения
    # ansible_become_user: root #На какого пользователя переключиться после подключения
    # ansible_become_method: su #Метод перехода под другого пользователя
