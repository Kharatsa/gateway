#!/usr/bin/env bash

ADMIN_USERNAME="ubuntu"
NGINX_CONFIG_DIR="nginxconfig"
NGINX_CONFIG_PATH="/home/$ADMIN_USERNAME/nginxconfig"
NGINX_CONFIG_REPO="https://github.com/Kharatsa/gateway.git"

echo "----------------------------------------------"
echo "------------ Pull repo updates ---------------"
echo "----------------------------------------------"

cd
if [ -d "$NGINX_CONFIG_PATH" ]; then
  cd $NGINX_CONFIG_PATH
  git pull
else
  mkdir -p $NGINX_CONFIG_PATH
  git clone $NGINX_CONFIG_REPO $NGINX_CONFIG_PATH
fi

sudo cp -R $NGINX_CONFIG_PATH/nginx/* /etc/nginx/
sudo nginx -s reload
