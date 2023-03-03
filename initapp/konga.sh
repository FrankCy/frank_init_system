#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: konga
#-------------------------------------------------#
cd /data/server;
# 配置数据库（前提要有postgres）
# ubuntu安装kong的可视化工具konga
# https://blog.csdn.net/qf0129/article/details/100557826
# 先进入postgres
sudo -u postgres psql;
# 设置postgres默认密码
\password postgres
#Enter new password:
#Enter it again:
CREATE USER konga WITH PASSWORD 'konga';
#CREATE ROLE
CREATE DATABASE konga OWNER konga;
#CREATE DATABASE
#退出postgresql
exit;
# 安装nodejs、npm和依赖包
sudo apt-get install nodejs npm
sudo npm install -g bower
sudo npm install -g gulp
# 安装konga项目
git clone https://github.com/pantsel/konga.git
cd /data/server/konga
npm i
cp .env_example .env
#编辑.env文件，将DB_URI的值改成如下
DB_URI=postgresql://konga:konga@localhost:5432/konga
#迁移数据库
node ./bin/konga.js prepare --adapter postgres --uri postgresql://localhost:5432/konga
#运行
npm run production
#访问
#http://127.0.0.1:1337
