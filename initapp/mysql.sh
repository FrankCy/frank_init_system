#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: MySQL安装
# 下载：https://downloads.mysql.com/archives/community/
# 下载2：https://downloads.mysql.com/archives/community/
#-------------------------------------------------#
. ./common/common.sh
function mysql5.7 {
  cd /data/server
  print_info 'mysql5.7 installing begin'
  wget https://cdn.mysql.com/archives/mysql-5.7/mysql-server_5.7.37-1ubuntu18.04_amd64.deb-bundle.ta;
  apt install libtinfo5 libmecab2;
  tar xvf mysql-server_5.7.37-1ubuntu18.04_amd64.deb-bundle.tar -C /data/server/mysql-deb;
  cd /data/server/mysql-deb;
  #NOTE：如果不需要安装测试相关的包，可以删除其中两个带 test 名称的 deb 文件：
  #mysql-community-test_5.7.37-1ubuntu18.04_amd64.deb
  #mysql-testsuite_5.7.37-1ubuntu18.04_amd64.deb
  #rm -f mysql-community-test_5.7.37-1ubuntu18.04_amd64.deb mysql-testsuite_5.7.37-1ubuntu18.04_amd64.deb
  dpkg -i mysql-*.deb;
  #  如果有问题：package architecture (amd64) does not match system (arm64)
  #  解决办法：
  #  问题:使用dpkg安装deb程序时报错package architecture (arm64) does not match system (amd64)
  #  解决方法：sudo dpkg --add-architecture arm64
  #  若出现package architecture (amd64) does not match system (arm64)
  #  则执行：sudo dpkg --add-architecture amd64
  #之后再重新执行 dpkg -i mysql-*.deb 命令，安装过程中，会提示让你输入 root 用户密码
  service mysql start;
  #使用 mysqld 脚本启动：
  /etc/init.d/mysql start;
  #使用 safe_mysqld 启动：
  safe_mysql&
  #使用 service 启动：
  service mysql stop;
  #使用 mysqld 脚本启动：
  /etc/init.d/mysql stop;
  #使用 service 启动：
  service mysql restart;

  print_info 'mysql5.7 installing end'
}

function mysql8 {
  print_info 'mysql8 installing begin'

  print_info 'mysql8 installing end'
}

function mysql_client {
  print_info 'mysql_client installing begin'

  print_info 'mysql_client installing end'
}

