#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: openrestry 会自带nginx
#-------------------------------------------------#

# 下载（2022年5月18日最新版）
wget https://openresty.org/download/openresty-1.21.4.1.tar.gz;

# 解压
tar -zxvf openresty-1.21.4.1.tar.gz;

# 安装必要组件
apt-get install libpcre3-dev \
    libssl-dev perl make build-essential curl;

apt-get install zlib1g-dev;

cd openresty-1.21.4.1/;

./configure;
# 可以指定各种选项
#./configure --prefix=/opt/openresty \
#            --with-luajit \
#            --without-http_redis2_module \
#            --with-http_iconv_module \
#            --with-http_postgres_module

# 帮助
#./configure --help

# 编译
make;
# 安装完后执行
make install;
# 安装后默认在/usr/local/openresty/nginx
# 启动，使用conf/nginx.conf配置
/usr/local/openresty/nginx/sbin/nginx -c conf/nginx.conf;

# 启动成功（查看端口，此时会被占用）
lsof -i:80;
