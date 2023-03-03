#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: PostgreSQL
#-------------------------------------------------#
cd /data/server;

sudo apt update;

sudo apt install postgresql postgresql-contrib;
# 查看版本
sudo -u postgres psql -c "SELECT version();"
# 加用户
sudo su - postgres -c "createuser frank";
# 加数据库
sudo su - postgres -c "createdb frank_db";
# 进入postgresql
sudo -u postgres psql;
# 赋权限：数据库frank_db所有权限给用户frank
grant all privileges on database frank_db to frank;

#远程访问PostgreSQL服务器
#默认情况下，PostgreSQL服务器仅在本地接口127.0.0.1上侦听。要启用对PostgreSQL服务器的远程访问。
#请打开配置文件postgresql.conf，然后在CONNECTIONS AND AUTHENTICATION节中找到listen_addresses的配置并改为listen_addresses = '*'。
#在本教程中我们将使用vim打开文件sudo vim /etc/postgresql/12/main/postgresql.conf。搜索关键字listen_addresses定位此行。
#修改完成后，保存文件并退出vim，然后使用命令sudo service postgresql restart重新启动PostgreSQL服务。
#使用ss命令ss -nlt | grep 5432验证更改。从PostgreSQL服务器的输出中可以看到，正在侦听在所有接口0.0.0.0:5432。
#最后一步是通过编辑pg_hba.conf文件将服务器配置为接受远程连接。pg_hba.conf文件有多个字段TYPE表示主机类型。
#DATABASE字段是PostgreSQL的数据的名称，USER是PostgreSQL的数据库。ADDRESS是源地址，0.0.0.0/0表示允许所有源地址。
#METHOD是身份验证方法，验证方法请查看PostgreSQL角色和身份验证。
#最后一步是在防火墙中打开端口5432。假设您正在使用UFW管理防火墙，并且要允许从192.168.1.0/24子网进行访问。
#sudo ufw allow proto tcp from 192.168.1.0/24 to any port 5432
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# host    all           all            0.0.0.0/0                md5

# https://www.jianshu.com/p/8e292615b9a4
# 先进入postgres
sudo -u postgres psql;
# 设置postgres默认密码
\password postgres
#Enter new password:
#Enter it again:
CREATE USER root WITH PASSWORD 'root';
#CREATE ROLE
CREATE DATABASE payment_dev OWNER root;
#CREATE DATABASE
CREATE DATABASE payment_test OWNER root;
#CREATE DATABASE
CREATE DATABASE payment_pro OWNER root;
#CREATE DATABASE