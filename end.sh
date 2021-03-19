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
    dnf -y install httpd
    dnf -y install nginx
    dnf -y install mysql-server

    #установка Prometheus
    useradd -m -s /bin/false prometheus
    mkdir /etc/prometheus
    mkdir /var/lib/prometheus
    chown prometheus /var/lib/prometheus/
    wget https://github.com/prometheus/prometheus/releases/download/v2.25.2/prometheus-2.25.2.linux-amd64.tar.gz
    tar -zxpvf prometheus-*.*.*.linux-amd64.tar.gz
    


}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi