#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp elasticsearch.repo /etc/yum.repos.d/
cp kibana.repo /etc/yum.repos.d/

#Установка, настройка и запуск elasticsearch
dnf -y install --enablerepo=elasticsearch elasticsearch
systemctl daemon-reload
systemctl start elasticsearch

#Установка, настройка и запуск kibana
dnf -y install kibana
cp kibana.yml /etc/kibana/
sed -i "s/serverip/$ip/g" /etc/kibana/kibana.yml
systemctl daemon-reload
systemctl start kibana

#Установка, настройка и запуск logstash
dnf -y install logstash
systemctl daemon-reload
systemctl start logstash

#Установка, настройка и запуск filebeat
dnf -y install filebeat
cp filebeat.yml /etc/filebeat/
sed -i "s/serverip/$ip/g" /etc/filebeat/filebeat.yml
filebeat modules enable nginx
filebeat modules enable apache 
systemctl daemon-reload
systemctl start filebeat
filebeat setup
filebeat -e