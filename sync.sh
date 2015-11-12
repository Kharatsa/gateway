#!/usr/bin/env bash

<<<<<<< HEAD
ADMIN_USERNAME="ubuntu"
LOCAL_SSH_KEY="odk-dev.pem"

NGINX_CONFIG_DIR="nginxconfig"
NGINX_CONFIG_PATH="/home/$ADMIN_USERNAME/nginxconfig"
NGINX_CONFIG_REPO="https://github.com/Kharatsa/gateway.git"
# CONFIG_BACKUP_DIR="/home/ubuntu/nginx-config-backups/$(date +%s)"
=======
AWS_ELASTIC_IP="52.4.26.168"
LOCAL_KEY="odk-dev.pem"
>>>>>>> parent of 952058e... move web app to default/root domain

rsync --delete -auve "ssh -i $LOCAL_KEY" \
  nginx/* \
  ubuntu@$AWS_ELASTIC_IP:/home/ubuntu/nginx-config

<<<<<<< HEAD
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
=======
ssh -i $LOCAL_KEY ubuntu@$AWS_ELASTIC_IP \
'bash -s' <<'ENDSSH'
  sudo su
  REMOTE_BACKUP_DIR="/home/ubuntu/nginx-config-backups/$(date +%s)"
  mkdir -p "$REMOTE_BACKUP_DIR"
  cp -R /etc/nginx/* "$REMOTE_BACKUP_DIR"
  chown -R ubuntu:ubuntu "$REMOTE_BACKUP_DIR"
  cp -R /home/ubuntu/nginx-config/* /etc/nginx/
  nginx -s reload
ENDSSH
>>>>>>> parent of 952058e... move web app to default/root domain
