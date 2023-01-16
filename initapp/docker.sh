#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: 安装docker
#-------------------------------------------------#
. ./common/common.sh
# 安装docker
function install_docker {
  print_info 'docker installing begin';
  # 更新软件包索引
  apt update;
  apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y;
  apt-get remove docker docker.io containerd runc -y;
  # 导入docker仓库的GPG密钥并安装docker运行命令
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
  apt update;
  apt install docker-ce docker-ce-cli containerd.io -y;
  # 查看docker状态
  systemctl status docker;
  print_info 'docker installing end';
}

# 删除docker
function uninstall_docker {
  print_info 'docker uninstall begin';
  print_info 'docker uninstall end';
}
