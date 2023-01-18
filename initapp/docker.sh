#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: 安装docker
# 以下配置会增加一段自定义内网 IPv6 地址，开启容器的 IPv6 功能，以及限制日志文件大小，防止 Docker 日志塞满硬盘（泪的教训）：
#cat > /etc/docker/daemon.json << EOF
#{
#    "log-driver": "json-file",
#    "log-opts": {
#        "max-size": "20m",
#        "max-file": "3"
#    },
#    "ipv6": true,
#    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
#    "experimental":true,
#    "ip6tables":true
#}
#EOF
#然后重启docker
#systemctl restart docker
#-------------------------------------------------#
. ./common/common.sh
# 安装docker
function install_docker {
  print_info 'docker installing begin';
  # 更新软件包索引
  apt update;
  apt upgrade -y;
  apt install curl vim wget gnupg dpkg apt-transport-https lsb-release ca-certificates
  apt-get remove docker docker.io containerd runc -y;
  # 导入docker仓库的GPG密钥并安装docker运行命令
  curl -sS https://download.docker.com/linux/debian/gpg | gpg --dearmor > /usr/share/keyrings/docker-ce.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-ce.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -sc) stable" > /etc/apt/sources.list.d/docker.list
  # 然后更新系统后即可安装 Docker CE：
  apt update
  apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  # 查看docker状态
  systemctl status docker;
  # 查看docker版本信息
  docker version
  print_info 'docker installing end';
}

# 删除docker
function uninstall_docker {
  print_info 'docker uninstall begin';
  print_info 'docker uninstall end';
}
