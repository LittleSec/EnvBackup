## 简介
PhASAR a LLVM-based Static Analysis Framework
1. 官网：https://phasar.org
2. github：https://github.com/secure-software-engineering/phasar

### [v1018](https://github.com/secure-software-engineering/phasar/releases/tag/v-pldi18) 和 [v1018](https://github.com/secure-software-engineering/phasar/releases/tag/v1018)
1. readme里的installation部分有漏掉
2. 只支持将所有依赖项（包括llvm和boost）安装在系统目录下
3. 相对完整的构建流程如下：
    ```shell
    # readme里的能用apt安装的依赖项整理
    sudo apt-get install zlib1g-dev libncurses5-dev sqlite3 libsqlite3-dev libmysqlcppconn-dev bear python3 doxygen graphviz

    # readme里没提的依赖项
    # Could NOT find CURL (missing: CURL_LIBRARY CURL_INCLUDE_DIR)
    sudo apt-get install curl libcurl4-openssl-dev
    # 该版本的下载llvm脚本使用svn下载，但ubuntu 16和18都不自带svn了
    # sudo apt-get install subversion
    # llvm的svm服务器已经无法访问了，直接下载源码压缩包即可，需要修改install-llvm-5.0.1.sh脚本

    # 下载和安装boost
    cd /path/to/you/want
    wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz
    tar xvf boost_1_66_0.tar.gz
    cd boost_1_66_0
    ./bootstrap.sh
    sudo ./b2 install

    # -----------------------------------
    cd /path/to/phasar
    # -----------------------------------

    # 在`.gitignore`文件里可以看到下载地址
    git clone https://github.com/nlohmann/json.git external/json --depth=1
    git clone https://github.com/google/googletest.git external/googletest --depth=1
    git clone https://github.com/pdschubert/WALi-OpenNWA.git external/WALi-OpenNWA --depth=1 # v-pldi18 不需要

    # 下载并安装llvm
    # 使用本路劲下修改后的install-llvm-5.0.1.sh脚本文件，使用方法不变
    cd utils
    ./install-llvm-5.0.1.sh 4 ~/ # 使用-j4构建，下载目录为~/

    # 对phasar源码的修改
    # 1. <json.hpp> 或 "json.hpp" --> <nlohmann/json.hpp>
    # 2. CMakeList.txt里json library路径问题
    #    [X] include_directories(external/json/src)
    #    [√] include_directories(external/json/single_include)
    # 3. 对于 v1018，文件lib\PhasarLLVM\Utils\TaintSensitiveFunctions.cpp使用了setw函数但却没有包含头文件<iomanip>

    # 构建phasar
    mkdir build
    cd build/
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j $(nproc)

    # testing
    ./phasar --help
    ```

4. `install-llvm-5.0.1.sh`会在llvm-5.0.1目录下git clone并构建binutils，构建过程中可能会失败，暂时未发现构建失败有什么影响

5. 本路径的`install-llvm-5.0.1.sh`脚本与phasar相比，主要修改了llvm各个模块的获取方式，从svn拉取源码变成了wget下载源码压缩包，并解压、按照原有的目录结构组织这些模块。下载路径：https://releases.llvm.org/download.html#5.0.1

6. 构建phasar成功，但是运行`./phasar`却报错未找到shared object file，如：
`./phasar: error while loading shared libraries: libboost_program_options.so.1.66.0: cannot open shared object file: No such file or directory`。
可以看出phasar在运行时没找到需要动态链接的boost库，这跟系统默认的链接路径有关，使用`./bootstrap.sh`安装boost时，通过配置文件`project-config.jam`可知默认安装的lib路径是`/usr/local/lib`，如果默认链接路径没有`/usr/local/lib`则需要添加。可以查看如下文件中是否含有该路径，添加后执行`ldconfig`命令即可：
    + `/etc/ld.so.conf`
    + `/etc/ld.so.conf.d/x86_64-linux-gnu.conf`

>参考：https://blog.csdn.net/jianhai1229/article/details/82416182
