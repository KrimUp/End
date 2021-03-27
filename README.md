# Проектная работа
"Создание скрипта автоматической установки и настройки балансировщика Nginx, сервера мониторинга Prometheus, системы логирования ELK stack, базы данных MySQL"
#
## Инструкция по использованию скрипта
* Скачать репозиторий с Github
  * git clone https://github.com/KrimUp/End.git
* Сделать файл **end.sh** испольнительным
  * chmod +x end.sh
* Запустить скрипт и следить за установкой :)
  * ./end.sh
#
## Настройка репликации базы данных проходит в ручном режиме
### Master
* Меняем ID сервера
  * nano /etc/my.cnf.d/mysql-server.cnf
  * server-id = 1
* Запускаем MySQL
  * systemctl start mysqld
* Создаем пользователя для репликации
  * CREATE USER 'replica'@'185.177.94.20' IDENTIFIED BY 'end';
  * GRANT REPLICATION SLAVE ON *.*TO 'replica'@'185.177.94.20';
* Проверяем бинлог и позицию
  * SHOW MASTER STATUS\G
### Slave
* Меняем ID сервера
  * nano /etc/my.cnf.d/mysql-server.cnf
  * server-id = 3
* Запускаем MySQL
  * systemctl start mysqld
* Меняем master
  * STOP SLAVE;
  * CHANGE MASTER TO MASTER_HOST='185.177.93.176', MASTER_USER='replica', MASTER_PASSWORD='end', MASTER_LOG_FILE='Бинлог', MASTER_LOG_POS=Позиция, GET_MASTER_PUBLIC_KEY = 1;
  * START SLAVE;
### Проверяем что получилось
* Master  
   * CREATE DATABASE OTUS_REPLICATION;
* Slave
   * SHOW DATABASES;  
