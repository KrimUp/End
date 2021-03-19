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
    cp prometheus-*.*.*.linux-amd64/prometheus  /usr/local/bin
    cp prometheus-*.*.*.linux-amd64/promtool  /usr/local/bin
    wget -O prometheus.yml https://raw.githubusercontent.com/KrimUp/End/main/prometheus.yml?token=AKLQHM62P7X4L3FMCNXJ4DDAKSHSK
    cp prometheus.yml  /etc/prometheus/
    firewall-cmd --add-port=9090/tcp --permanent
    firewall-cmd --reload
    wget -O prometheus.service https://raw.githubusercontent.com/KrimUp/End/main/prometheus.service?token=AKLQHM65QRVDVSHNSCCEGF3AKSBQQ
    cp prometheus.service /etc/systemd/system
    

    #установка node_exporter
    useradd -m -s /bin/false node_exporter
    wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
    tar -zxpvf node_exporter-*.*.*.linux-amd64.tar.gz
    cp node_exporter-*.*.*.linux-amd64/node_exporter /usr/local/bin
    chown node_exporter:node_exporter /usr/local/bin/node_exporter
    firewall-cmd --add-port=9100/tcp  --permanent
    firewall-cmd --reload
    wget -O node_exporter.service https://raw.githubusercontent.com/KrimUp/End/main/node_exporter.service?token=AKLQHM2KOMXI2VEJNHGR7BDAKSESM
    cp node_exporter.service /etc/systemd/system
    
    #включение демонов prometheus и node_exporter
    systemctl daemon-reload
    systemctl start node_exporter
    systemctl enable node_exporter
    systemctl start prometheus
    systemctl enable prometheus

}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi