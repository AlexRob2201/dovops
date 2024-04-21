#!/bin/bash

# Install Prometheus
sudo apt-get update
sudo apt-get install -y prometheus

sudo sed -i 's/localhost:9100/192.168.31.11:9100/g' /etc/prometheus/prometheus.yml
sudo sed -i 's/# - "first_rules.yml"/- "alert.rules.yml"/g' /etc/prometheus/prometheus.yml
echo '  - job_name: "new_job"' | sudo tee -a /etc/prometheus/prometheus.yml > /dev/null
echo '    static_configs:' | sudo tee -a /etc/prometheus/prometheus.yml > /dev/null
echo '      - targets: ["192.168.31.11:9104"]' | sudo tee -a /etc/prometheus/prometheus.yml > /dev/null

# Install Grafana
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install grafana -y

# Install AlertManager
#sudo apt-get install prometheus-alertmanager
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
sudo tar xvfz alertmanager-0.26.0.linux-amd64.tar.gz
cd alertmanager-0.26.0.linux-amd64
sudo cp alertmanager /usr/local/bin/
sudo cp alertmanager.yml /etc/prometheus/
sudo cat <<EOF > /lib/systemd/system/alertmanager.service
[Unit]
Description=AlertManager Server Service
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/alertmanager --config.file /etc/prometheus/alertmanager.yml --web.external-url=http://192.168.31.10:9093

[Install]
WantedBy=multi-user.target
EOF
sudo cp /vagrant_data/alert.rules.yml /etc/prometheus/
sudo cp /etc/prometheus/alertmanager.yml /etc/prometheus/alertmanager.yml.save
sudo cat <<EOF >  /etc/prometheus/alertmanager.yml
global:
  resolve_timeout: 5m

route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 10s
  repeat_interval: 10s
  receiver: 'email'
receivers:
- name: 'email'
  email_configs:
  - to: 'buxenko8@gmail.com'
    from: 'buxenko8@gmail.com'
    smarthost: smtp.gmail.com:587
    auth_username: 'buxenko8@gmail.com'
    auth_identity: 'buxenko8@gmail.com'
    auth_password: 'pwvxbkpbuiopufuz'
inhibit_rules:
  - source_match:
      severity: 'warning'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
EOF


#reload and start tools
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager
sudo systemctl restart prometheus
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
