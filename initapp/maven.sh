#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:安装maven
# 准备
# 1：需要JDK
#-------------------------------------------------#
. ./common/common.sh
# 下载3.6地址
MAVEN_3_6_URL=https://github.com/apache/maven/archive/refs/tags/maven-3.6.3.tar.gz
# 安装目录
INSTALL_PATH=/data/server
function maven3_6 {
  echo_info 'maven 3.6 installing being'
  # 下载maven到/tmp下
  wget $MAVEN_3_6_URL -P /tmp;
  # 解压到指定目录（/data/server）
  tar -zxf /tmp/maven-3.6.3.tar.gz -C $INSTALL_PATH;
  # 设置环境变量
  nano /etc/profile.d/maven.sh;
  # 写入配置
  echo 'export JAVA_HOME=/usr/lib/jvm/default-java
        export M2_HOME=/opt/maven
        export MAVEN_HOME=/opt/maven
        export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh;
  chmod +x /etc/profile.d/maven.sh;
  # 生效环境变量
  source /etc/profile.d/maven.sh;
  # 检查mvn安装情况
  mvn -version;
  echo_info 'maven 3.6 installing end'
}