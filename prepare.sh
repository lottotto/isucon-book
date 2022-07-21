#!/bin/bash
source util.sh

is_err=false

if [[ -z "${KEY_PATH}" ]]; then
  error "転送する秘密鍵のパス \${KEY_PATH} が空です。"
  is_err=true
fi

if [[ -z "${GIT_URL}" ]]; then
  error "origin のURL \${GIT_URL} が空です。"
  is_err=true
  
fi

if [[ "$#" = "0" ]]; then
  error "ssh接続先を引数に渡してください。"
  info "Usage: prepare.sh server1 server2 server3"
  is_err=true
fi

if "${is_err}"; then
  exit 1
fi

info KEY_PATH: ${KEY_PATH}
info GIT_URL: ${GIT_URL}
info SERVER: "$@"

read -p "ok? (y/N): " yn
case "$yn" in
  [yY]*) : ;;
  *) echo "abort"; exit 1;;
esac

for SERVER in "$@"; do
  # git用 秘密鍵送付
  scp ${KEY_PATH} ${SERVER}:~/
  KEY_PATH_FILENAME=$(basename ${KEY_PATH})
  info KEY_PATH_FILE_NAME: ${KEY_PATH_FILENAME}

  # git 準備
  ssh ${SERVER} <<EOC
  sudo -s
  echo "===== 秘密鍵移動 =========="
  mv \${PWD}/${KEY_PATH_FILENAME} /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
  chown root:root /root/.ssh/id_rsa
  echo "===== /root/.ssh =========="
  ls -al /root/.ssh
  echo "===== リモートリポジトリ 設定 =========="
  cd /
  echo current dir: \${PWD}
  git init
  git remote add origin ${GIT_URL}
  git pull origin main:main
  git checkout main
  git push --set-upstream origin main
  echo "===== Git トラッキング対象 =========="
  git ls-files
EOC
done
