#! /bin/sh

# Exit script on failure
set -e

echo "\nOpenCV Install Script for RaspberryPI using Python\n"

echo "\nInstalling dependencies...\n"

sudo apt-get -y install libhdf5-dev libhdf5-serial-dev &&
sudo apt-get -y install libqtwebkit4 libqt4-test &&
wget https://bootstrap.pypa.io/get-pip.py &&
sudo python3 get-pip.py &&
sudo pip install opencv-contrib-python &&
sudo pip install "picamera[array]"

echo "Installation was successful!"
