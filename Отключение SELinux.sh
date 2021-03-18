#!/bin/bash
#Обьявление переменных
var1=$"SELINUX=enforcing"
var2=$(getenforce)
#Проверка на выполение от пользователя root
if [ `whoami` = root ]
then
{
    #Проверка конфиг файла selinux, и диалог вкл/выкл
    if grep $var1 /etc/selinux/config
    then
        read -p "SElinux включен в конфиге, выключить? (y/n)" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
         sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
        fi
    else
        read -p "SElinux выключен в конфиге, включить? (y/n)" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
         sed -i 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
        fi
    fi

     #Проверка текущей сессии на selinux и диалог вкл/выкл
    if  [ "$var2" == "Enforcing" ]
    then
    echo
    read -p "SELinux включен в данной сессии, выключить? (y/n)" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
         setenforce 0
         echo
        else
         echo 
        fi
    else
    echo
    read -p "SELinux выключен в данной сессии, включить? (y/n)" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
         setenforce 1
         echo
        else
         echo
        fi
    fi
}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi