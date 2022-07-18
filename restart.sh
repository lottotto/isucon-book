#!/bin/bash

function logging () {
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  printf "${RED}$1${NC}\n"
}

logging "===== git pull =========="
git pull

logging "===== verify nginx.conf =========="
nginx -t

logging "===== restart nginx =========="
systemctl restart nginx

logging "===== logrotate nginx =========="
logrotate -vf /etc/logrotate.d/nginx
ls -al /var/log/nginx

