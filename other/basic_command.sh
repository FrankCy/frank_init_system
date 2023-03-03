#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:
#-------------------------------------------------#
# 查看机器型号
# $ arch
#x86_64
# $ uname -a
#Linux centos-elk 3.10.0-1160.45.1.el7.x86_64

# 创建目录 和 # 赋权限
mkdir -p /data/server  /data/logs  /opt/data /opt/settings /opt/logs;
chmod -R 777 /data/server  /data/logs  /opt/data /opt/settings /tmp;
chown -R worker:worker /data/server /opt/data /opt/settings  /data/logs /opt/logs /tmp;


