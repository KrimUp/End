#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
#Проверка на выполение от пользователя root
if [ `whoami` = root ]
then
{
    #установка ПО с помощью пакетного менеджера
    dnf -y update
    dnf -y install wget
    dnf -y install git
    
    dnf -y install nginx
    dnf -y install mysql-server

    #клонирование репозитория
    git clone https://github.com/KrimUp/End.git

    #установка балансировщика nginx
    


    #установка prometheus

}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi