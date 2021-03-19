#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
#Проверка на выполение от пользователя root
if [ `whoami` = root ]
then
{
    dnf -y update
    dnf -y install git
    dnf -y install httpd
    dnf -y install nginx
    dnf -y install mysql-server
}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi