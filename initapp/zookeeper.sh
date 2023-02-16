#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: 安装ZK
# 前提：
#-------------------------------------------------#
. ./common/common.sh

function cluster {
  cd /data/server;
  # 下载一个版本儿
  wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.1/apache-zookeeper-3.8.1-bin.tar.gz;
  # 创建目录
  mkdir -p /data/server/apache-zookeeper-3.8.1;
  # 解压到/usr/local下
  tar -zxvf apache-zookeeper-3.8.1-bin.tar.gz -C /data/server/;
  # 改名字
  mv apache-zookeeper-3.8.1-bin zookeeper-3.8.1;
  # 新增zk目录
  mkdir -p /data/server/zookeeper-3.8.1/data;
  mkdir -p /data/server/zookeeper-3.8.1/logs;
  # 复制默认配置，改为zoo.cfg
  cp /data/server/zookeeper-3.8.1/conf/zoo_sample.cfg /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  # 修改核心配置zoo.cfg
  # 替换
  dataDir_old='/tmp/zookeeper';
  dataDir_url='/data/server/zookeeper-3.8.1/data';
#  sed -ig "s#/tmp/zookeeper#/data/server/zookeeper-3.8.1/data#" /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  sed -ig "s#${dataDir_old}#${dataDir_url}#" /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  # 写入dataLogDird
  echo 'dataLogDir=/data/server/zookeeper-3.8.1/logs' >> /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  # 写入集群配置，定义map：key是机器的PID，value是对应的节点
  declare -A map
  map[1]="192.168.163.151"
  map[2]="192.168.163.152"
  map[3]="192.168.163.149"

  for key in ${!map[@]};do
      echo "server."${key}"="${map[${key}]}":2888:3888" >> /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  done

  # 查看下配置
  cat /data/server/zookeeper-3.8.1/conf/zoo.cfg;
  # 新增PID文件 并 设置PID
  touch /data/server/zookeeper-3.8.1/data/myid;
  # PID，与MAP key相同
  echo 2 > /data/server/zookeeper-3.8.1/data/myid;

  # 启动
  /data/server/zookeeper-3.8.1/bin/zkServer.sh start

  # 查看状态
  /data/server/zookeeper-3.8.1/bin/zkServer.sh status
}