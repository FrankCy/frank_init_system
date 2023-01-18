#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:
#-------------------------------------------------#
. ./common/common.sh
# 参考：https://www.gingerdoc.com/tutorials/how-to-install-jenkins-on-ubuntu-20-04
function install_jenkins {
  print_info 'jenkins installing begin'
  # 将存储库密钥添加到系统
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  # 将 Debian 软件包存储库地址附加到服务器的sources.list
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  # 运行update以便apt使用新的存储库
  sudo apt update
  # 安装 Jenkins 及其依赖项
  sudo apt install jenkins
  # 使用systemctl以下命令启动 Jenkins
  sudo systemctl start jenkins
  # 使用该status命令来验证 Jenkins 是否成功启动
  sudo systemctl status jenkins
  print_info '分割 设置防火墙 begin ------------------------------------------------------'
  # 设置防火墙开通8080
  sudo ufw allow 8080
  # 注意：如果防火墙处于非活动状态，以下命令将允许 OpenSSH 并启用防火墙：
  sudo ufw allow OpenSSH
  sudo ufw enable
  # 检查ufw的状态以确认新规则
  sudo ufw status
  print_info '分割 设置防火墙 end ------------------------------------------------------'
  # 输出jenkins密码
  sudo cat /var/lib/jenkins/secrets/initialAdminPassword
  print_info 'jenkins installing end'
}

# 卸载
function uninstall_jenkins {
  print_info 'jenkins uninstall begin'
  print_info 'jenkins uninstall end'
}