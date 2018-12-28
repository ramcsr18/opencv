#! /bin/sh
# Install script for the latest version of OpenCV with the extra modules added
# If installing with python, make sure to start the virtualenv before running the script
# Tested on Ubuntu 16.04 LTS, x64
# Written by Min Hoo Lee
# December 28, 2016 (12/28/2016)

# Exit script on failure
set -e

echo "\nOpenCV Install Script for Ubuntu\n"

# Activate all the apt-get repositories
echo "\nAdding all apt-get repositories...\n"
sudo add-apt-repository main 
sudo add-apt-repository universe
sudo add-apt-repository multiverse 
sudo add-apt-repository restricted 
sudo apt-get -y update

echo "\nInstalling dependencies...\n"
# Developer tools
sudo apt-get install git build-essential cmake pkg-config wget

# File I/O
sudo apt-get install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev

# Video I/O
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev

# GUI (gtk)
sudo apt-get install libgtk-3-dev

# Optimization (BLAS)
sudo apt-get install libatlas-base-dev gfortran liblapacke-dev

echo "\nDownloading the latest version of OpenCV...\n"
git clone https://github.com/opencv/opencv.git
cd opencv
TAG=`git describe --abbrev=0 --tags`

echo "\nInstalling OpenCV $TAG with the Extra Modules...\n"
git checkout $TAG
mkdir build
cd build

git clone https://github.com/opencv/opencv_contrib.git
git --git-dir=opencv_contrib/.git --work-tree=opencv_contrib checkout $TAG

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=./opencv_contrib/modules ..

make -j$(nproc)
sudo make install
sudo ldconfig

echo "Installation was successful!"
