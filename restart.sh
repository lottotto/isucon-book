#!/bin/bash
source util.sh

info "===== verify nginx.conf =========="
nginx -t

info "===== restart nginx =========="
systemctl restart nginx

info "===== logrotate nginx =========="
logrotate -vf /etc/logrotate.d/nginx
ls -al /var/log/nginx

