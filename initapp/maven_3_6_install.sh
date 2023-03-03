#!/bin/bash
#-------------------------------------------------#
wget https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -P /data/server;
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