#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: 安装kibana，可操作ES
#-------------------------------------------------#
. ./common/common.sh

function install_kibana {
  ########################
  #-----------------------
  # 建议通过root执行，然后通过修改权限给指定用户
  #-----------------------

  # 查找kibana
  # https://www.elastic.co/cn/downloads/kibana
  # 找到和ES版本相同的版本
  # 要符合当前系统，查看系统命令：arch或 uname -a
  wget https://artifacts.elastic.co/downloads/kibana/kibana-7.16.3-linux-aarch64.tar.gz

  # 解压
  tar -zxvf kibana-7.16.3-linux-aarch64.tar.gz -C /data/server/
  mv kibana-7.16.3-linux-aarch64 kibana7.16.3

  # 修改配置
  echo 'server.port: 5601' >> /data/server/kibana7.16.3/config/kibana.yml
  # 设置本机IP
  echo 'server.host: "192.168.163.143"' >> /data/server/kibana7.16.3/config/kibana.yml
  echo 'server.name: "frank-kibana"' >> /data/server/kibana7.16.3/config/kibana.yml
  echo 'elasticsearch.hosts: ["http://localhost:9200"]' >> /data/server/kibana7.16.3/config/kibana.yml
#  echo 'elasticsearch.username: "kibana_system"' >>/data/server/kibana7.16.3/config
#  echo 'elasticsearch.password: "pass"' >>/data/server/kibana7.16.3/config
  # 修改权限
  sudo chown -R frank:frank /data/server/kibana7.16.3
  # 启动
  nohup /data/server/kibana7.16.3/bin/kibana > start_kibana.log &

  # 查看启动日志
  tail -100f start_kibana.log

  # 验证

}