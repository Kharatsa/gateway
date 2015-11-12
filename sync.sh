#!/usr/bin/env bash

NGINX_CONFIG_DIR="nginxconfig"
NGINX_CONFIG_PATH="/home/$ADMIN_USERNAME/nginxconfig"
NGINX_CONFIG_REPO="https://github.com/Kharatsa/gateway.git"
# CONFIG_BACKUP_DIR="/home/ubuntu/nginx-config-backups/$(date +%s)"
rsync --delete -auve "ssh -i $LOCAL_KEY" \
  nginx/* \
  ubuntu@$AWS_ELASTIC_IP:/home/ubuntu/nginx-config

echo "----------------------------------------------"
echo "------------ Pull repo updates ---------------"
echo "----------------------------------------------"

cd
if [ -d "$NGINX_CONFIG_DIR" ]; then
  echo "Pulling"
  cd $NGINX_CONFIG_PATH
  git pull
else
  echo "Making"
  mkdir -p $NGINX_CONFIG_PATH
  git clone $NGINX_CONFIG_REPO $NGINX_CONFIG_PATH
fi

# sudo mkdir -p "$CONFIG_BACKUP_DIR"
# sudo cp -R /etc/nginx/* "$CONFIG_BACKUP_DIR"
# sudo chown -R ubuntu:ubuntu "$CONFIG_BACKUP_DIR"
sudo cp -R $NGINX_CONFIG_PATH/nginx/* /etc/nginx/
sudo nginx -s reload
