#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
dnf -y install httpd
dnf -y install nginx
mkdir /var/www/8080
mkdir /var/www/8081
cp Loadbalancerd/8080.html /var/www/8080/index.html
cp Loadbalancerd/8081.html /var/www/8081/index.html
cp Loadbalancerd/httpd.conf /etc/httpd/conf/
cp Loadbalancerd/8080.conf /etc/httpd/conf.d/
cp Loadbalancerd/8081.conf /etc/httpd/conf.d/
cp Loadbalancerd/upstream.conf /etc/nginx/conf.d/
cp Loadbalancerd/nginx.conf /etc/nginx/
sed -i "s/serverip/$ip/g" /etc/nginx/conf.d/upstream.conf
setsebool -P httpd_unified 1
systemctl start httpd
systemctl start nginx