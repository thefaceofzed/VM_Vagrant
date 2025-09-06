#!/bin/bash
set -euo pipefail

# ── Clean out Oracle's MySQL repo (causes GPG errors here)
sudo dnf -y remove mysql80-community-release || true
sudo rm -f /etc/yum.repos.d/mysql-community*.repo || true
sudo dnf -y clean all
sudo rm -rf /var/cache/dnf

# ── Use CentOS Stream 9 MySQL module (prefer 8.0; fallback 8.4)
sudo dnf -y module reset mysql || true
(sudo dnf -y module enable mysql:8.0) || (sudo dnf -y module enable mysql:8.4)

# ── Install server + client
sudo dnf -y install mysql-server mysql

# ── Start & enable
sudo systemctl enable --now mysqld

# ── Listen on all interfaces so host port-forward 3307 works
sudo mkdir -p /etc/my.cnf.d
echo -e "[mysqld]\nbind-address=0.0.0.0" | sudo tee /etc/my.cnf.d/bind.cnf >/dev/null
sudo systemctl restart mysqld

# ── Create DB + user
sudo mysql <<'SQL'
CREATE DATABASE IF NOT EXISTS demo_db;
CREATE USER IF NOT EXISTS 'devuser'@'%' IDENTIFIED BY 'devpass';
GRANT ALL PRIVILEGES ON demo_db.* TO 'devuser'@'%';
FLUSH PRIVILEGES;
SQL

# ── Load demo data (ok if already loaded)
mysql -udevuser -pdevpass demo_db < /vagrant/database/create-table.sql || true
mysql -udevuser -pdevpass demo_db < /vagrant/database/insert-demo-data.sql || true

echo "✅ MySQL ready. From host: mysql -h 127.0.0.1 -P 3307 -u devuser -pdevpass -D demo_db -e 'SELECT COUNT(*) FROM users;'"
