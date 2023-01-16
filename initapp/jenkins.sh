#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:
#-------------------------------------------------#
# 安装
# https://www.myfreax.com/how-to-install-jenkins-on-ubuntu-20-04/
function install_jenkins {
  echo 'jenkins installing being'
  sudo apt update;
  sudo apt install openjdk-11-jdk;
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -;
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list';
  sudo apt update;
  sudo apt install jenkins;
  sudo systemctl status jenkins;
  echo 'jenkins installing end'
}

# 卸载
function uninstall_jenkins {
  echo 'jenkins uninstall being'
  echo 'jenkins uninstall end'
}