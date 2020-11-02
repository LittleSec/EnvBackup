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

# parallel download
OS_TYPE=$(uname)
if [ $OS_TYPE = "Linux" ]; then
  Nproc=$(nproc)
elif [ $OS_TYPE = "Darwin" ]; then # macOS
  Nproc=$(sysctl -n hw.logicalcpu)
else
  echo "[\!] Can handle this OS type, default Nproc=4"
  Nproc=4
fi

Pfifo="./$$.fifo"
mkfifo Pfifo
exec 4<> Pfifo
rm -rf Pfifo
for i in `seq 1 $Nproc`; do
  echo >&4
done

# SRC_URL=https://wx1.sinaimg.cn/large
SRC_URL=https://wx2.sinaimg.cn/large
# SRC_URL=https://wx3.sinaimg.cn/large
# SRC_URL=https://wx4.sinaimg.cn/large

succ_cnt=0
fail_cnt=0

for fjpg in `ls $1`; do
  read -u 4 # get token
  {
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
    echo >&4 # set toker
  } &
done

wait
exec 4>&-
exec 4<&-

echo "===== Summary ====="
echo "   succ: $succ_cnt"
echo "   fail: $fail_cnt"
echo "==================="
echo "[+] Done"
