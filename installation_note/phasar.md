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
    sudo apt-get install subversion

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
