#!/bin/bash
source util.sh

wget https://github.com/tkuchiki/alp/releases/download/v1.0.10/alp_linux_amd64.tar.gz -O /tmp/alp.tar.gz
tar xzf /tmp/alp.tar.gz -C /tmp
install /tmp/alp /usr/local/bin/alp

info "===== verify installation ====="
alp --version
