#!/bin/bash
#Проверка на выполение от пользователя root
if [ `whoami` = root ]
then
{
    dnf -y install httpd
    dnf -y install nginx
    dnf -y install mysql-server
}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi