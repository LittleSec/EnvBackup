# Ubuntu下如何用命令行运行deb安装包，dpkg
## deb包
1. 安装: `sudo dpkg -i <package.deb>`, (`-i`==`--install`)
2. 查看详细信息: `sudo dpkg -I <package.deb>`, (`-I`==`--info`)
3. 查看文件结构: `sudo dpkg -c <package.deb>`, (`-c`==`--contents`)
4. 卸载:
    + 通过`dpkg -l`查看deb包安装后的名字
    + `sudo dpkg -r 上面的包名字`
    + `sudo dpkg -P 上面的包名字`做一次清除
## 已安装的软件
1. 查看信息: `sudo dpkg -l <package>`, (`-l`==`--list`)
2. 查看所需文件: `sudo dpkg -L <package>`, (`-L`==`--listfiles`)
3. 查看详细信息: `sudo dpkg -s <package>`, (`-s`==`--status`)
4. 卸载: `sudo dpkg -r <package>`, (`-r`==`--remove`)
5. 完全清除: `sudo dpkg -P <package>`, (`-P`==`--purge`)
>注: dpkg命令无法自动解决依赖关系。如果安装的deb包存在依赖包，则应避免使用此命令，或者按照依赖关系顺序安装依赖包。


# Ubuntu中使用dpkg安装deb文件提示依赖关系问题，仍未被配置
出错后使用如下命令: `sudo apt-get install -f`，等分析完之后，重新使用`sudo dpkg –i <deb>`。


# 重定向及nohup不输出的方法
1. 重定向
    + 0: 标准输入
    + 1: 标准输出，默认使用，默认是屏幕。
    + 2: 标准错误输出
    + `2>&1`: 将标准错误输出重定向到标准输出
    + `/dev/null`: 特殊文件，所有重定向到它的信息都会消失得无影无踪
2. nohup: 自动将输出写入nohup.out文件中，如果文件很大的话，nohup.out就会不停的增大，可以利用`/dev/null`来解决这个问题
    + 错误信息重定向到log文件: `nohup ./program >/dev/null 2>log &`
    + 连错误信息也不保留: `nohup ./program >/dev/null 2>&1 &`


# 查询进程和结束进程
1. `ps -ef | grep <process-name>`
    + `ps`: 将某个进程显示出来
        - `-e`: 显示所有程序
        - `-f`: 显示更多信息: UID,PPIP,C与STIME栏位
    + `|`: 管道
    + `grep`: 查找命令
2. `kill -<sign> <pid>`
    + 给某个进程pid发送了一个信号sign
    + 默认信号SIGTERM
    + `-9`发送的信号是SIGKILL，即exit。exit信号不会被系统阻塞
        - `kill -9 <pid>` 
    + 杀死父进程和所有子进程: `kill -TERM <pid>`


# 如何在Ubuntu上开启SSH服务器
1. `sudo apt-get install openssh-server`
2. `ps -e | grep ssh` ==> 有`sshd`说明ssh服务已经启动。
3. 若没开启则: `sudo service ssh start`


# Host key verification failed. (ssh)
1. 每次成功ssh连接远程操作，都会把每个访问过计算机的公钥(public key)都记录在主机的目录`~/.ssh/known_hosts`下（也可能是其他名字或目录，可以在附近找找）。下次访问相同服务器时，会核对公钥。如果公钥不同，会发出警告，避免受到DNS Hijack之类的攻击。
2. 因此找到后打开文件并删除对应记录即可。
   

# Linux下查看文件和文件夹大小
1. `df`显示目前所有文件系统的可用空间及使用情形。
    + `df -T`: 产看分区的文件系统类型
    + `df -h`: 查看系统中文件的使用情况，以人类易读方式输出
2. `du`查询文件或文件夹的磁盘使用空间，不带参数会递归列出所有文件和文件夹
    + 查看当前目录下各个文件及目录占用空间大小: `du -sh *`
    + 查看某个目录的总大小: `du -sh <dir>`，没有`<dir>`则默认是当前目录，注意`*`和`./`是不一样的
    + 指定深入目录层数: `--max-depth=<num>`
        + `du -h --max-depth=1 <dir>` 
3. `df -h`和`du -sh`显示的磁盘大小不一致原因及解决办法
    + 使用`rm`命令删除文件时，只有当该文件不存在任何link才会被删除，当有进程访问这个文件时,这个文件的实际占用空间就不会释放
    + `du`是根据文件名进行的空间统计，使用rm时该文件对系统来说已经不可见，所以不会统计这个文件。
    + `df`则是磁盘实际占用的数量
    + 查看正在使用的已删除的文件: `lsof | grep delete`，kill掉进程即可。


# fatal error: sys/cdefs.h: No such file or directory (Ubuntu 16.04 64-bit)
1. `sudo apt install libc6-dev libc6-dev-i386`


# fatal error: openssl/bio.h: No such file or directory
1. `sudo apt-get install libssl-dev`


# fatal error: curses.h: No such file or directory (compile Busybox)
1. 在使用menuconfig时，需要ncurses库的支持: `sudo apt-get install libncurses5-dev libncursesw5-dev`


# fatal error: bits/c++config.h: No such file or directory
1. `sudo apt-get install build-essential libc6-dev libc6-dev-i386 gcc-multilib g++-multilib`


# ubuntu vi
1. ubuntu预装的是vim tiny版本，我们常用的是vim full版本
    + `sudo apt-get remove vim-common`
    + `sudo apt-get install vim`
2. 没网则设置vi不使用兼容模式: `:set nocompatible`


# make install 提示 makeinfo is missing on your system
1. `sudo apt-get install texinfo`


# unable to locate package
1. `sudo apt-get update`
2. `sudo apt-get upgrade`


# cp: omitting directory
1. `cp -r <source> <target>`
2. `-r`表示递归，在此表示递归的复制目录下的文件和目录
3. 可以举一反三到其他命令
    + `chmod`是-R


# Linux下内存查看命令
1. `free`/`top`，后者主要产看系统进程，也能显示系统内存
2. `free -m`
3. 当可用内存少于额定值的时候，就会开会进行交换。查看额定值: `cat /proc/meminfo`


# 终端模式下: 字体大小设置
1. `sudo dpkg-reconfigure console-setup。`
2. 弹出`Configuring console-setup`界面，选择适当的编码格式，一般选择默认的`UTF-8`，选择OK
3. 在接下来的界面里选择字体，可以依次尝试，选择默认的`latin1 and latin5 -western Europe and Turkic languages`，这种字体下有较大的字体大小选择空间。
4. 选择字体显示效果。
5. 接下来的界面选择字体大小。
6. 或**快捷键**: （数字键盘貌似不行）
    + 放大: `Ctrl` + `Shift` + `+`
    + 缩小: `Ctrl` + `-`


# fatal error: linux/compiler-gcc5.h: No such file or directory (compile Linux kernel)
1. 原因: 系统太新
2. 网上下一个`compiler-gcc5.h`放要编译内核模块的内核代码的`include/linux/`下
3. 或在要编译内核目录下: `cp include/linux/compiler-gcc4.h include/linux/compiler-gcc5.h`


# 不要轻易彻底地改用户名！！
1. 有些debug模式下编译的工具会附带上绝对路径信息，如果彻底更改用户名，那么绝对路径信息也会错误（例如llvm和clang）


# 交换空间创建、挂载、卸载
1. 创建8GB的空文件（在此名为/tmp/swap1）：`dd if=/dev/zero of=/tmp/swap1 bs=1M count=8192`
2. 格式化为交换分区：`mkswap /tmp/swap1`
3. 挂载交换分区：`sudo swapon /tmp/swap1`
4. 卸载交换分区：`sudo swapoff /tmp/swap1`


# `/usr/bin/ld: cannot find -lcurses`
1. `sudo apt install ncurses-dev`

# 双系统、boot分区
>源链接（防止意外404）：http://tieba.baidu.com/p/5597848278
1. 新手们不要单独分 boot 分区了，那就是一个巨坑
2. 早期为什么会分单独的 boot 分区？
    + 在2000年左右那会儿，硬盘容量快速发展（实际上也就10G、20G），但是一部分旧式的 BIOS 还不支持 LBA 模式，不支持引导距离 MBR 太远的硬盘分区，现在的小朋友们根本无法想象吧！
    + 当时的 Linux 还是极少数 GNU 爱好者的玩具，一般都是作为第二系统和 Windows 共存，而且 Linux 在硬盘中的位置大都靠后。
    + 有时候因为安装的根分区距离 MBR 太远无法引导，于是流行在`C:\`盘后面紧跟着建立一个100、200M 的`/boot`分区，以防无法启动。
3. 在现在的硬件条件下，完全没有必要划分 boot 分区，那只会带来麻烦，容量如果太小，会使你无法安装、升级新内核。现在实际上只需要一个根分区挂在`/`，一个 HOME 分区挂在`/home`，连`/swap`分区都可有可无，因为完全可以用`swapfile`代替。
    + 单独的HOME分区是为了保护你的个人文件安全，防止系统崩溃时丢失文件。

# Could not access KVM kernel module: Permission denied
1. 是否支持硬件虚拟化: `grep -Eoc '(vmx|svm)' /proc/cpuinfo`, 0 表示不支持, 大于零则为支持的核心数
2. 系统是否可以运行kvm: `kvm-ok`, 该工具包含在`cpu-checker`包里
3. 将用户添加到 kvm 组: `sudo usermod -aG kvm $USER`
4. 启动/卸载(自动识别) kvm 内核模块
    + `sudo modprobe kvm`
    + `sudo modprobe kvm_intel`
5. 卸载
    + `sudo rmmod kvm`

# kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs
1. 该文件 `/etc/modprobe.d/qemu-system-x86.conf`, 加入如下两行
    + `options kvm_intel nested=1`(或`options kvm_intel nested=1 # enable_apicv=n`)
    + `options kvm ignore_msrs=1`


# ln -s src tgr 的 src 最好用绝对路径

# asm/errno.h: No such file or directory
1. `sudo apt install gcc-multilib`
2. `ln -s /usr/include/asm-generic /usr/include/asm`
    + `ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm`

# cloc: Can't use an undefined value as an ARRAY reference
1. 该问题只在的 cloc --version 1.60版本出现，ubuntu 16.04 的apt源默认的版本是的1.60，所以要么换系统，要么不要使用 apt 安装
    + https://github.com/AlDanial/cloc/issues/126


# there is no application installed for AppImage
1. 修改权限 `chmod +x *.AppImage`


# ipython, when use Tab for autocomplete, will err and exit
>unsure solution
1. pip3 unnstall jedi pyreadline
