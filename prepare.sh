#!/bin/bash

if [[ -z "${KEY_PATH}" ]]; then
  echo "転送する秘密鍵のパス \${KEY_PATH} が空です。"
  exit 1
fi

if [[ -z "${GIT_URL}" ]]; then
  echo "origin のURL \${GIT_URL} が空です。"
  exit 1
fi

echo KEY_PATH: ${KEY_PATH}
echo GIT_URL: ${GIT_URL}

read -p "ok? (y/N): " yn
case "$yn" in
  [yY]*) : ;;
  *) echo "abort"; exit 1;;
esac

# git用 秘密鍵送付
scp ${KEY_PATH} private-isu-app:~/
KEY_PATH_FILENAME=$(basename ${KEY_PATH})
echo KEY_PATH_FILE_NAME: ${KEY_PATH_FILENAME}

# git 準備
ssh private-isu-app <<EOC
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
echo "===== Git トラッキング対象 =========="
git ls-files
EOC


