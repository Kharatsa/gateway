#!/usr/bin/env bash
set -x

ADMIN_USERNAME="ubuntu"
LOCAL_SSH_KEY="odk-dev.pem"
NGINX_CONFIG_DIR="/home/$ADMIN_USERNAME/nginxconfig"
NGINX_CONFIG_REPO="https://github.com/Kharatsa/gateway.git"
# CONFIG_BACKUP_DIR="/home/ubuntu/nginx-config-backups/$(date +%s)"


echo "----------------------------------------------"
echo "------------ Pull repo updates ---------------"
echo "----------------------------------------------"

if [ -d "$NGINX_CONFIG_DIR" ]; then
  mkdir -p $NGINX_CONFIG_DIR
  git clone $NGINX_CONFIG_REPO $NGINX_CONFIG_DIR
else
  cd $NGINX_CONFIG_DIR
  git pull
fi

# sudo mkdir -p "$CONFIG_BACKUP_DIR"
# sudo cp -R /etc/nginx/* "$CONFIG_BACKUP_DIR"
# sudo chown -R ubuntu:ubuntu "$CONFIG_BACKUP_DIR"
sudo cp -R $NGINX_CONFIG_DIR/* /etc/nginx/
sudo nginx -s reload
