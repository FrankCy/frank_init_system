#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: jdk安装
#-------------------------------------------------#
function install_java8_22_1 {
  echo 'java8_22_1 installing being'
  cd /usr/local;
  wget '找个1.8.0_221版本的jdk';
  tar -zxvf jdk1.8.0_221.tar.gz;
  echo 'export JAVA_HOME=/usr/local/jdk1.8.0_221
  export PATH=$JAVA_HOME/bin:$PATH
  export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' >> /etc/profile;
  source /etc/profile;
  echo 'java8_22_1 installing end'
}

function uninstall_java8_22_1 {
  echo 'uninstall java8_22_1 begin'
  echo 'uninstall java8_22_1 end'
}
