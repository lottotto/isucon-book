#!/bin/bash
source util.sh

info "===== verify nginx.conf =========="
nginx -t

info "===== restart nginx =========="
systemctl restart nginx

info "===== logrotate nginx =========="
ACCESS_LOG="/var/log/nginx/access.log"
if [[ -s "${ACCESS_LOG}" ]]; then
    cp -ap ${ACCESS_LOG} ${ACCESS_LOG}.$(date +%Y%m%d-%H%M%S)
    rm ${ACCESS_LOG}
    nginx -s reopen
else
    info "${ACCESS_LOG} is 0 bytes. nothing to do."
fi
ls -al /var/log/nginx

