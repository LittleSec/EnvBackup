#!/bin/bash

num_cores=1
target_dir=./
re_number="^[0-9]+$"

if [ "$#" -ne 2 ] || ! [[ "$1" =~ ${re_number} ]] || ! [ -d "$2" ]; then
	echo "usage: <prog> <# cores> <directory>" >&2
	exit 1
fi

num_cores=$1
target_dir=$2

echo "Getting the complete LLVM source code"
echo "Get llvm"
# wget https://releases.llvm.org/5.0.1/llvm-5.0.1.src.tar.xz
tar xvf llvm-5.0.1.src.tar.xz
mv llvm-5.0.1.src ${target_dir}llvm-5.0.1
echo "Get clang"
# wget https://releases.llvm.org/5.0.1/cfe-5.0.1.src.tar.xz
tar xvf cfe-5.0.1.src.tar.xz
mv cfe-5.0.1.src ${target_dir}llvm-5.0.1/tools/clang
echo "Get clang-tools-extra"
# wget https://releases.llvm.org/5.0.1/clang-tools-extra-5.0.1.src.tar.xz
tar xvf clang-tools-extra-5.0.1.src.tar.xz
mv clang-tools-extra-5.0.1.src ${target_dir}llvm-5.0.1/tools/clang/tools/extra
echo "Get lld"
# wget https://releases.llvm.org/5.0.1/lld-5.0.1.src.tar.xz
tar xvf lld-5.0.1.src.tar.xz
mv lld-5.0.1.src ${target_dir}llvm-5.0.1/tools/lld
echo "Get polly"
# wget https://releases.llvm.org/5.0.1/polly-5.0.1.src.tar.xz
tar xvf polly-5.0.1.src.tar.xz
mv polly-5.0.1.src ${target_dir}llvm-5.0.1/tools/polly
echo "Get compiler-rt"
# wget https://releases.llvm.org/5.0.1/compiler-rt-5.0.1.src.tar.xz
tar xvf compiler-rt-5.0.1.src.tar.xz 
mv compiler-rt-5.0.1.src ${target_dir}llvm-5.0.1/projects/compiler-rt
echo "Get openmp"
# wget https://releases.llvm.org/5.0.1/openmp-5.0.1.src.tar.xz
tar xvf openmp-5.0.1.src.tar.xz
mv openmp-5.0.1.src ${target_dir}llvm-5.0.1/projects/openmp
echo "Get libcxx"
# wget https://releases.llvm.org/5.0.1/libcxx-5.0.1.src.tar.xz
tar xvf libcxx-5.0.1.src.tar.xz
mv libcxx-5.0.1.src ${target_dir}llvm-5.0.1/projects/libcxx
echo "Get libcxxabi"
# wget https://releases.llvm.org/5.0.1/libcxxabi-5.0.1.src.tar.xz
tar xvf libcxxabi-5.0.1.src.tar.xz
mv libcxxabi-5.0.1.src ${target_dir}llvm-5.0.1/projects/libcxxabi
echo "Get test-suite"
# wget https://releases.llvm.org/5.0.1/test-suite-5.0.1.src.tar.xz
tar xvf test-suite-5.0.1.src.tar.xz
mv test-suite-5.0.1.src ${target_dir}llvm-5.0.1/projects/test-suite

cd ${target_dir}llvm-5.0.1
echo "Get new-ld with plugin support"
git clone --depth 1 git://sourceware.org/git/binutils-gdb.git binutils
cd binutils
mkdir build
cd build
echo "build binutils"
../configure --disable-werror
make -j${num_cores} all-ld
cd ../..
echo "LLVM source code and plugins are set up"
echo "Build the LLVM project"
mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_CXX1Y=ON -DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_BINUTILS_INCDIR=$(pwd)/../binutils/include ..
make -j${num_cores}
echo "Run all tests"
# make -j3 check-all
echo "Installing LLVM"
sudo make install
echo "Successfully installed LLVM"
