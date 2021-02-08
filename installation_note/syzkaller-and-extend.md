# syzkaller 及其衍生的工具
> eg. razzer

1. some dependency: `sudo apt install python-setuptools quilt libssl-dev dwarfdump libelf-dev`
2. install qemu (and qemu-kvm):
    + `sudo apt install qemu`
    + `sudo apt install qemu-kvm libvirt-dev`(optional)
3. (optional)启用 kvm，并将用户添加到 kvm 组
    + `sudo modprobe kvm`
    + `sudo modprobe kvm_intel`
    + `sudo usermod -aG kvm $USER`
4. 关于文件系统镜像 debootstrap
    1. ```sudo apt install debootstrap debian-keyring debian-archive-keyring```
    2. debootstrap其实就是一个脚本文件，通过`which debootstrap`可知其路径，通过 apt 源安装的话，其脚本里的 mirror 地址是有误的（至少在ubuntu 18.04里是这样的），因此需要修改地址
        + 通过搜索 http 可以定位需要修改的地方
        + 将地址修改为: **http://archive.debian.org/debian-archive/debian**
    3. 或者通过源码安装debootstrap
        ```shell
        wget http://ftp.ru.debian.org/debian/pool/main/d/debootstrap/debootstrap_1.0.115.tar.gz
        tar xzf debootstrap_1.0.114.tar.gz 
        cd debootstrap/
        sudo make install
        debootstrap --version
        ```
    4. 但凡在运行create-image.sh(准确来说是debootstrap)时遇到包找不到等网络问题，都可以检查 mirror 地址是否又更换了


### 对于 razzer 来说
获取文件系统镜像 debootstrap 可以只修改 `razzer/scripts/misc/create-image.sh`
    + ```sudo debootstrap --include=openssh-server,curl,tar,gcc,libc6-dev,time,strace,sudo,less,psmisc wheezy wheezy http://archive.debian.org/debian-archive/debian```
    + >refer to https://www.debian.org/releases/wheezy/
    + >http://pub.nethence.com/xen/debootstrap
