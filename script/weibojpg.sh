#!/bin/bash

# check args num
if [ 1 -ne $# ]; then
  echo "Usage: $0 /path/to/jpg_dir"
  exit 1
fi

# check wget
WGET_PATH=$(which wget)
if [ -x $WGET_PATH ]; then
  echo "[+] Found wget: $WGET_PATH"
else
  echo "[-] Can not Found wget"
  exit 127
fi

# SRC_URL=https://wx1.sinaimg.cn/large
SRC_URL=https://wx2.sinaimg.cn/large
# SRC_URL=https://wx3.sinaimg.cn/large
# SRC_URL=https://wx4.sinaimg.cn/large

succ_cnt=0
fail_cnt=0

for fjpg in `ls $1`; do
  cmd="$WGET_PATH $SRC_URL/$fjpg -o /dev/null"
  # echo $cmd
  $cmd
  if [ 0 -ne $? ]; then
    echo "[-] fail: $fjpg"
    let fail_cnt+=1
  else
    echo "[+] succ: $fjpg"
    let succ_cnt+=1
  fi
done

echo "===== Summary ====="
echo "   succ: $succ_cnt"
echo "   fail: $fail_cnt"
echo "==================="
echo "[+] Done"
