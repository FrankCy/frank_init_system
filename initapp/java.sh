#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: jdk安装
# 查找历史版本：http://www.oracle.com/technetwork/java/javase/archive-139210.html
# 登陆后下载，复制链接到下面脚本
#-------------------------------------------------#
#（已验证 ubuntu20.04.4）
. ./common/common.sh
function install_java8_22_1 {
  jdk_url=https://download.oracle.com/otn/java/jdk/8u351-b10/10e8cce67c7843478f41411b7003171c/jdk-8u351-linux-aarch64.tar.gz?AuthParam=1676442691_e191153a898f1a78df10da52b883fcc3
  print_info 'java8_22_1 installing begin'
  cd /usr/local;
  # -O重命名
  wget $jdk_url -O jdk1.8.0_221.tar.gz;
  tar -zxvf jdk1.8.0_221.tar.gz;
  echo 'export JAVA_HOME=/usr/local/jdk1.8.0_221
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' >> /etc/profile;
  source /etc/profile;
  # 查看版本
  java -version;
  print_info 'java8_22_1 installing end'
}

function uninstall_java8_22_1 {
  print_info 'uninstall java8_22_1 begin'
  print_info 'uninstall java8_22_1 end'
}
