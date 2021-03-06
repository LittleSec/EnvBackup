# if ubuntu in vmware
1. vm-tools maybe useful: `sudo apt intall open-vm-tools-dev`

# Firstly<a name="firstly"></a>
```shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y gcc g++ build-essential libc6-dev libc6-dev-i386 gcc-multilib g++-multilib
sudo apt-get install -y git vim cmake autoconf autogen automake tmux ninja-build htop net-tools
```

# short cut
Ctrl+h隐藏文件

# for pretty
```shell
sudo apt-get install -y zsh fonts-powerline
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
run zsh
vim ~/.zshrc # ZSH_THEME="random"
chsh -s `which zsh`
sudo shutdown -h now
```

# LLVM and Clang
1. 对于新电脑的依赖: `sudo apt install -y python3-dev libxml2-dev libncurses5-dev swig libedit-dev`
## some tips(现在更建议这种方法~)
1. 可以在[llvm.org](http://releases.llvm.org/download.html)只下载llvm，不必下载整个project。
    + 但必须要装了llvm再clang，clang依赖于llvm，至少要让clang知道llvm的路径
    + ***通常做法***：下载llvm和cfe(clang)，把cfe整个文件夹移动到llvm/tools目录下并改名为clang，可能还有lld
2. 需要大内存和磁盘空间
3. 内存不够可以由交换空间弥补，现在安装ubuntu一般不会单独设置一个合理大的交换空间（都是意思意思设置一个，也不怎么需要用），可能需要手动创建挂载一个较大的交换空间。
    + 对于clang建议：swap分区大小+memory内存大小总和 > 16GB
    + ***内存够不够跟make的时候用-j选项有关，所以make出错时监控一下内存看看是否的在出错的时候内存满了，满了则较少-j***
4. 需要多个llvm和clang版本共存时，可以在cmake时指定***release***减少占用空间。`-D CMAKE_BUILD_TYPE=Release`，不指定的话默认是Debug
```shell
cd /path/to/save/sourcecode
git clone https://github.com/llvm/llvm-project.git -b llvmorg-8.0.0 --depth=1
cd llvm-project
mkdir -p install
mkdir -p build 
cd build
cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libcxx;libcxxabi;lld" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$HOME/mybin/llvm ../llvm
# cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS='clang;lld;compiler-rt;libcxx;libcxxabi;lld' -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug -DLLVM_TARGETS_TO_BUILD='AArch64;ARM;BPF;X86' -DCMAKE_INSTALL_PREFIX='/path/to'  ../llvm

make -j4
sudo make install
```
5. 卸载：`rm -rf $(cat build/install_manifest.txt)`
6. 直接装 **Pre-Built Binaries** 的一个风险：若缺乏某些依赖，使用时不一定会报错，只是运行结果可能与预期不同，对 debug 不友好

# deb
1. [vscode](https://code.visualstudio.com/)
    + 已经可以在商店里下载了，也可以使用命令：`snap install code --classic`
2. [搜狗输入法for Linux](https://pinyin.sogou.com/linux/)
    + Settings-->Language Support-->Keyboard input method system: choose **fcitx**
    + sudo shutdown -h now
    + 屏幕右上方有了企鹅输入fcitx(keyboard icon)-->configureFcitx-->add Sogou Pinyin

# qemu<a name="qemu"></a>
```shell
sudo apt-get install -y zlib1g-dev glib2.0 libpixman-1-dev libsdl-dev flex bison
cd /path/to/save/sourcecode
git clone -b stable-3.0 https://git.qemu.org/git/qemu.git/ --depth 1
# wget https://download.qemu.org/qemu-3.0.0.tar.xz
mkdir build-qemu && cd build-qemu
../qemu/configure --target-list="arm-softmmu,aarch64-softmmu,i386-softmmu,x86_64-softmmu"
make -j4
```

# Python3 packet
```shell
sudo apt install -y python3-dev python3-pip
pip3 install ipython numpy panda virtualenv
```

# shadowsocks(abandon)
```shell
see https://github.com/shadowsocks/shadowsocks-qt5/releases and download newest version
chmod a+x ***.AppImage
```
double clicking (or run it from terminal).

# git
```bash
git config --global core.editor "vim"
# git config --global credential.help cache
git config --global credential.help store
```
