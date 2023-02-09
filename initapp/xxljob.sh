#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: jdk安装
# 前提：
# 安装java
# 安装mysql
# 安装maven
#-------------------------------------------------#
. ./common/common.sh

function single {
  # 流程：
  # 1.安装必须的程序  jdk、mysql、maven
  # 2.github下载源码
  # 3.解压并修改相关配置（mysql）
  # 4.启动admin

  # 下载xxl https://github.com/xuxueli/xxl-job/releases
  # 2.3.1: https://codeload.github.com/xuxueli/xxl-job/zip/refs/tags/2.3.1
  # 2.3.0: https://codeload.github.com/xuxueli/xxl-job/zip/refs/tags/2.3.0
  wget https://codeload.github.com/xuxueli/xxl-job/zip/refs/tags/2.3.0 -O /data/server/xxl-job-2.3.0.zip;

  # 解压
  unzip /data/server/xxl-job-2.3.0.zip;

  # 修改配置：xxl-job/xxl-job-admin/src/main/resources/application.properties
  # 127.0.0.1:3306/xxl_job替换成自己的
  replace_db_url="192.168.163.1:3306"
  replace_db_database="xxl_job?useUnicode"
  replace_db_username="spring.datasource.username=root"
  replace_db_password="spring.datasource.password=root"
  # 替换数据库配置
  sed -ig "s/127.0.0.1:3306/"${replace_db_url}"/" /data/server/xxl-job-2.3.0/xxl-job-admin/src/main/resources/application.properties;
  sed -ig "s/xxl_job?useUnicode/"${replace_db_database}"/" /data/server/xxl-job-2.3.0/xxl-job-admin/src/main/resources/application.properties;
  sed -ig "s/spring.datasource.username=root/"${replace_db_username}"/" /data/server/xxl-job-2.3.0/xxl-job-admin/src/main/resources/application.properties;
  sed -ig "s/spring.datasource.password=root_pwd/"${replace_db_password}"/" /data/server/xxl-job-2.3.0/xxl-job-admin/src/main/resources/application.properties;
  cat /data/server/xxl-job-2.3.0/xxl-job-admin/src/main/resources/application.properties;
  # 进入安装目录构建
  cd /data/server/xxl-job-2.3.0;
  mvn clean package;
  # 启动
  nohup java -jar /data/server/xxl-job-2.3.0/xxl-job-admin/target/xxl-job-admin-2.3.0.jar > /data/server/xxl-job-start.log &
}

function cluster {
  # 集群模式，需要在多节点配置多个xxl-job，然后Nginx通过域名负载均衡访问即可
}