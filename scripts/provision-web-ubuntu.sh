#!/bin/bash
set -eux

# Update packages
sudo apt-get update -y
sudo apt-get install -y nginx git

# Clear default site
sudo rm -rf /var/www/html/*

# Clone site from GitHub
REPO_URL=$1
sudo git clone "$REPO_URL" /var/www/html

# Move actual HTML into root (the theme has content under /src or /docs or /dist)
if [ -d "/var/www/html/dist" ]; then
  sudo cp -r /var/www/html/dist/* /var/www/html/
fi
if [ -d "/var/www/html/src" ]; then
  sudo cp -r /var/www/html/src/* /var/www/html/
fi

# Permissions
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Start Nginx
sudo systemctl enable nginx
sudo systemctl restart nginx

echo "✅ Web server ready. Visit http://192.168.56.10"
