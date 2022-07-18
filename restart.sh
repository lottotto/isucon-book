#!/bin/bash
source util.sh

info "===== verify nginx.conf =========="
nginx -t

info "===== restart nginx =========="
systemctl restart nginx

info "===== logrotate nginx =========="
mv /var/log/nginx/access.log /var/log/nginx/access.log.$(date +%Y%m%d-%H%M%S)
ls -al /var/log/nginx

