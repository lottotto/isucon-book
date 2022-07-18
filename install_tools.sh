#!/bin/bash
source util.sh

wget https://github.com/tkuchiki/alp/releases/download/v1.0.10/alp_linux_amd64.zip -O /tmp/alp.zip
install /tmp/alp.zip /usr/local/bin/alp