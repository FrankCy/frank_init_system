#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: 安装elasticsearch
# https://blog.csdn.net/qq_26039331/article/details/115024218
# 索引操作：https://blog.csdn.net/Extraordinarylife/article/details/120409609
#-------------------------------------------------#
. ./common/common.sh
# 查看ES版本
# > curl -X GET 172.16.22.173:9200
#{
#  "name" : "node-1",
#  "cluster_name" : "elasticsearch",
#  "cluster_uuid" : "_eep9v2BQNi6LdexGj2AQw",
#  "version" : {
#    "number" : "7.8.1",
#    "build_flavor" : "default",
#    "build_type" : "rpm",
#    "build_hash" : "b5ca9c58fb664ca8bf9e4057fc229b3396bf3a89",
#    "build_date" : "2020-07-21T16:40:44.668009Z",
#    "build_snapshot" : false,
#    "lucene_version" : "8.5.1",
#    "minimum_wire_compatibility_version" : "6.8.0",
#    "minimum_index_compatibility_version" : "6.0.0-beta1"
#  },
#  "tagline" : "You Know, for Search"
#}

function install_es7 {
  print_info "install es7 begin"
  # 安全问题，无法使用root启动，所以通过其他用户操作
  # 下载ES
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.16.3-linux-x86_64.tar.gz
  # 解压至/data/server
  tar -xzvf elasticsearch-7.16.3-linux-x86_64.tar.gz -C /data/server
  # 重命名
  mv elasticsearch-7.16.3 es7.16.3
  # 启动
  nohup /data/server/es7.16.3/bin/elasticsearch > start_es.log &
  # 启动错误：ubuntu ElasticsearchException[Failure running machine learning native code. This could be due to running on an unsupported OS or distribution,
  # 解决错误，在/conf/elasticsearch.yml中添加xpack.ml.enabled: false
  # 解决办法：https://discuss.elastic.co/t/org-elasticsearch-bootstrap-startupexception-elasticsearchexception-failure-running-machine-learning-native-code/280865
  # 输出日志
  tail -100f start_es.log

  # 启动无误之后
  # 通过curl 查看 curl 127.0.0.1 9200
  #  {
  #  "name" : "first",
  #  "cluster_name" : "elasticsearch",
  #  "cluster_uuid" : "qnm5QZ9tSmK43DTGcylaJw",
  #  "version" : {
  #    "number" : "7.16.3",
  #    "build_flavor" : "default",
  #    "build_type" : "tar",
  #    "build_hash" : "4e6e4eab2297e949ec994e688dad46290d018022",
  #    "build_date" : "2022-01-06T23:43:02.825887787Z",
  #    "build_snapshot" : false,
  #    "lucene_version" : "8.10.1",
  #    "minimum_wire_compatibility_version" : "6.8.0",
  #    "minimum_index_compatibility_version" : "6.0.0-beta1"
  #  },
  #    "tagline" : "You Know, for Search"
  #  }

  # 基于安全问题，es只允许服务器上访问，无法通过本地远程访问，需要修改配置
  # /conf/
  # 添加：
  #network.host: 0.0.0.0
  #network.bind_host: 0.0.0.0
  #network.publish_host: 0.0.0.0
  #discovery.seed_hosts: ["0.0.0.0", "[::0]"]
  # 然后重启ES

  # 如果要查看Elasticsearch服务日志记录，可以使用以下命令：
  sudo journalctl -u elasticsearch
  # 注意：
  # Elasticsearch数据存储在/var/lib/elasticsearch目录中
  # 配置文件位于/etc/elasticsearch中
  # Java启动选项可以在/etc/default/elasticsearch文件中进行配置
  # 参考：https://www.myfreax.com/how-to-install-elasticsearch-on-ubuntu-18-04/

  print_info "install es7 end"
}

function install_es8 {

}