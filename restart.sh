#!/bin/bash
source util.sh

info "===== verify nginx.conf =========="
nginx -t

info "===== restart nginx =========="
systemctl restart nginx

info "===== logrotate nginx =========="
cp -ap /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%Y%m%d-%H%M%S)
rm /var/log/nginx/access.log
nginx -s reopen
ls -al /var/log/nginx

