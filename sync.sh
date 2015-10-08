#!/usr/bin/env bash

AWS_ELASTIC_IP="52.4.26.168"
LOCAL_KEY="odk-dev.pem"

rsync --delete -auve "ssh -i $LOCAL_KEY" \
  nginx/* \
  ubuntu@$AWS_ELASTIC_IP:/home/ubuntu/nginx-config

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