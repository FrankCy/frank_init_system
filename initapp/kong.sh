#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: kong
# 需安装postgres
# 需
#-------------------------------------------------#
# 安装：
# https://bynss.com/linux/609083.html
curl -Lo kong.2.5.0.amd64.deb "https://download.konghq.com/gateway-2.x-ubuntu-$(lsb_release -cs)/pool/all/k/kong/kong_2.5.0_amd64.deb"
sudo dpkg -i kong.2.5.0.amd64.deb
# 如果出现：package architecture (amd64) does not match system (arm64)
# 执行下面的话，再安装
# sudo dpkg --add-architecture amd64
kong config init
#database = off
#declarative_config: /home/ubuntu/kong.yml
kong start -c kong.yml
curl -i https://localhost:8001


