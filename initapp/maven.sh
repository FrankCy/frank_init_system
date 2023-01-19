#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:安装maven
# 准备
# 1：需要JDK
#-------------------------------------------------#
#（已验证 ubuntu20.04.4）
. ./common/common.sh
# 下载3.6地址
MAVEN_3_6_URL=https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
# 安装目录
INSTALL_PATH=/data/server
function maven3_6 {
  print_info 'maven 3.6 installing begin'
  # 下载maven到/tmp下
  wget $MAVEN_3_6_URL -P /data/server;
  # 解压并重命名（/data/server）
  unzip /data/server/apache-maven-3.6.3-bin.zip;
  # 写入配置（先安装java，查看java.sh）
  echo 'export M2_HOME=/data/server/apache-maven-3.6.3
export MAVEN_HOME=/data/server/apache-maven-3.6.3
export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile;
  # 生效环境变量
  source /etc/profile;
  # 检查mvn安装情况
  mvn -version;
  print_info 'maven 3.6 installing end, 请调整settings.xml'
}