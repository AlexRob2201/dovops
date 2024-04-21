#!/bin/bash

# Install & Configure MySQL Server
PASS="password"
USER="mysqld_exporter"
DB="Shop"

sudo apt-get install -y mysql-server
sudo systemctl start mysql

sudo mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE $DB;
CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $DB.* TO '$USER'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Install & Configure Prometheus Node Exporter
sudo apt-get install -y prometheus-node-exporter

# wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
# tar xvfz node_exporter-1.6.1.linux-amd64.tar.gz
# cd node_exporter-1.6.1.linux-amd64
# sudo cp node_exporter /usr/local/bin/
# sudo useradd -rs /bin/false node_exporter
# sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
# sudo cat <<EOF > /etc/systemd/system/node_exporter.service
# [Unit]
# Description=Node Exporter
# After=network.target

# [Service]
# ExecStart=/usr/local/bin/node_exporter

# [Install]
# WantedBy=default.target
# EOF
# sudo systemctl daemon-reload
# sudo systemctl enable node_exporter
# sudo systemctl start node_exporter

#Install & Configure Prometheus MySQL Exporter
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.13.0/mysqld_exporter-0.13.0.linux-amd64.tar.gz
tar xvfz mysqld_exporter-0.13.0.linux-amd64.tar.gz
cd mysqld_exporter-0.13.0.linux-amd64
sudo cp mysqld_exporter /usr/local/bin/
sudo useradd -rs /bin/false mysqld_exporter
sudo chown mysqld_exporter:mysqld_exporter /usr/local/bin/mysqld_exporter

sudo cat <<EOF > /etc/mysql/.my.cnf
[client]
user=mysqld_exporter
password=password
host=192.168.31.11
EOF

sudo cat <<EOF > /etc/systemd/system/mysqld_exporter.service
[Unit]
 Description=Prometheus MySQL Exporter
 After=network.target

 [Service]
 Type=simple
 Restart=always
 ExecStart=/usr/local/bin/mysqld_exporter \
 --config.my-cnf /etc/mysql/.my.cnf \
 --collect.global_status \
 --collect.info_schema.innodb_metrics \
 --collect.auto_increment.columns \
 --collect.info_schema.processlist \
 --collect.binlog_size \
 --collect.info_schema.tablestats \
 --collect.global_variables \
 --collect.info_schema.query_response_time \
 --collect.info_schema.userstats \
 --collect.info_schema.tables \
 --collect.perf_schema.tablelocks \
 --collect.perf_schema.file_events \
 --collect.perf_schema.eventswaits \
 --collect.perf_schema.indexiowaits \
 --collect.perf_schema.tableiowaits \
 --collect.slave_status \
 --web.listen-address=192.168.31.11:9104

 [Install]
 WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mysqld_exporter
sudo systemctl start mysqld_exporter

# sudo apt-get install -y prometheus-mysqld-exporter

