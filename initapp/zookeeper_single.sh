#!/bin/bash
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
# 新增PID文件 并 设置PID
touch /data/server/zookeeper-3.8.1/data/myid;
# PID，与MAP key相同
echo 2 > /data/server/zookeeper-3.8.1/data/myid;
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
# 单节点，只需要写入单个即可
declare -A map
map[1]="10.1.2.60"

for key in ${!map[@]};do
    echo "server."${key}"="${map[${key}]}":2888:3888" >> /data/server/zookeeper-3.8.1/conf/zoo.cfg;
done

# 查看下配置
cat /data/server/zookeeper-3.8.1/conf/zoo.cfg;

# 启动
/data/server/zookeeper-3.8.1/bin/zkServer.sh start

# 查看状态
/data/server/zookeeper-3.8.1/bin/zkServer.sh status


###### 问题
###1. org.apache.zookeeper.server.admin.AdminServer$AdminServerException: Problem starting AdminServer on address 0.0.0.0, port 8080 and command URL /commands
### 解决办法：https://www.jianshu.com/p/181a69836fe9