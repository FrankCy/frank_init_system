#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: nginx
#-------------------------------------------------#
. ./common/common.sh

function install {
  print_info 'nginx installing begin';
  cd /opt;
  # 安装gcc g++的依赖库
  sudo apt-get install build-essential;
  sudo apt-get install libtool;
  # pcre依赖库
  # 正则一般都会用到，建议装
  sudo apt-get install libpcre3 libpcre3-dev;
  # zlib依赖库
  sudo apt-get install zlib1g-dev;
  # ssl依赖库
  sudo apt-get install openssl;
  # 安装nginx
  wget http://nginx.org/download/nginx-1.23.0.tar.gz;
  tar -zxvf nginx-1.23.0.tar.gz;
  mv nginx-1.23.0 nginx;
  cd nginx;
  ./configure;
  make & make install;
  echo 'export NGINX_HOME=/usr/local/nginx
export PATH=$PATH:$NGINX_HOME/sbin' >> /etc/profile;
  source /etc/profile
  nginx -V;
  print_info 'nginx installing begin';
}