#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: jdk安装
#-------------------------------------------------#
. ./common/common.sh
# docker 安装 prometheus
# 前提要先安装docker
function docker_prometheus {
  print_info 'docker install prometheus begin'
  # 下载prometheus镜像
  docker pull prom/prometheus:v2.39.1;
  # 创建外部挂载目录
  mkdir -p /docker/server/prometheus;
  # 进入目录
  cd /docker/server/prometheus/;
  # 创建文件
  touch rules.yml;
  touch prometheus.yml;
  # 启动prometheus
  docker run --name prometheus -p 9090:9090 --restart=always \
  -v /docker/server/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
  -v /docker/server/prometheus/rules.yml:/etc/prometheus/rules.yml \
  -itd prom/prometheus:v2.39.1 \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.enable-lifecycle;
  # 检查是否启动
  docker ps -a;
  print_info 'docker install prometheus end'
}