#!/bin/bash
source util.sh

info "===== install alp ====="
wget https://github.com/tkuchiki/alp/releases/download/v1.0.10/alp_linux_amd64.tar.gz -O /tmp/alp.tar.gz
tar xzf /tmp/alp.tar.gz -C /tmp
install /tmp/alp /usr/local/bin/alp

info "===== verify installation ====="
alp --version

info "===== install percona-toolkit ====="
apt update
apt install percona-toolkit

info "===== verify installation ====="
pt-query-digest --version

info "===== install netdata ====="
# https://learn.netdata.cloud/docs/agent/packaging/installer/methods/kickstart
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry

info "===== verify installation ====="
curl localhost:19999