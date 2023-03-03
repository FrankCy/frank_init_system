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
  echo 'export NGINX_HOME= /usr/local/nginx
export PATH=$PATH:$NGINX_HOME/sbin' >> /etc/profile;
  source /etc/profile;
  # 启动
  /usr/local/nginx/sbin/nginx;
  # 查看版本
  nginx -V;
  print_info 'nginx installing begin';
}
###### 其它常用命令 #######
# 验证nginx配置是否正确
# nginx -t
# 重新加载nginx，使其有效
# nginx -s reload

###### Nginx 配置文件详解 ######
# https://www.runoob.com/w3cnote/nginx-setup-intro.html

# /usr/local/nginx/conf/nginx.conf 初始配置简介如下：
#...              #全局块
#
#events {         #events块
#   ...
#}
#
#http      #http块
#{
#    ...   #http全局块
#    server        #server块
#    {
#        ...       #server全局块
#        location [PATTERN]   #location块
#        {
#            ...
#        }
#        location [PATTERN]
#        {
#            ...
#        }
#    }
#    server
#    {
#      ...
#    }
#    ...     #http全局块
#}