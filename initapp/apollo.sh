#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:安装Apollo
# 准备工作：
# 1：MySQL数据库，初始化Apollo相关表
# 2：对应版本的URL，可通过wget下载
#-------------------------------------------------#
. ./common/common.sh
function apollo1.4 {
  print_info 'apollo 1.4 installing begin'
  CONFIG_URL=http://apollo-config-1.4.tar.gz
  ADMIN_URL=http://apollo-admin-1.4.tar.gz
  PORTAL_URL=http://apollo-portal-1.4.0%202.zip

  # portal meta service配置，自行修改
  METAL_LOCAL=http://localhost:8077
  META_DEV=http://localhost:8077
  META_FAT=http://localhost:8077
  META_UAT=http://localhost:8077
  META_LPT=http://localhost:8077
  META_PRO=http://localhost:8077

  # 数据库配置
  MYSQL_CONFIG_URL=jdbc:mysql://127.0.0.1:3306/apollo_config_db?characterEncoding=utf8
  MYSQL_PORTAL_URL=jdbc:mysql://127.0.0.1:3306/apollo_portal_db?characterEncoding=utf8
  MYSQL_USER=root
  MYSQL_PASSWORD=Admin172.16.0.95

  #如果文件夹不存在，则创建文件夹
  DATA_SERVER_PATH="/data/server/"
  if [ ! -d "$DATA_SERVER_PATH" ]; then
    mkdir $DATA_SERVER_PATH
  else
    print_info '文件夹已存在'
    print_info '进入文件夹'
    cd $DATA_SERVER_PATH
  fi
  # -----------------------------------------------Apollo Config----------------------------------------------------------------
  print_info '开始下载ApolloConfig'
  wget -O apollo-configservice.tar.gz $CONFIG_URL
  print_info '结束下载ApolloConfig'

  print_info '开始解压ApolloConfig'
  mkdir ./apollo-configservice && tar -xzvf apollo-configservice.tar.gz -C ./apollo-configservice --strip-components 1
  print_info '结束解压ApolloConfig'

  print_info '开始修改ApolloConfig config'
  apolloConfigConfigPath=$DATA_SERVER_PATH'apollo-configservice/config/application-github.properties'
  sed -i -e "s#^spring.datasource.url=.*#spring.datasource.url=${MYSQL_CONFIG_URL}#g" ${apolloConfigConfigPath}
  sed -i -e "s#^spring.datasource.username=.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloConfigConfigPath}
  sed -i -e "s#^spring.datasource.password=.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloConfigConfigPath}
  print_info '结束修改ApolloConfig config'

  print_info '---------------- ApolloConfig config ----------------'
  cat ${apolloConfigConfigPath}
  print_info '---------------- ApolloConfig config ----------------'

  print_info '开始启动ApolloConfig'
  sh ./apollo-configservice/scripts/startup.sh > config_start.log 2>&1
  print_info '结束启动ApolloConfig'

  # -----------------------------------------------Apollo Admin----------------------------------------------------------------

  cd $DATA_SERVER_PATH
  print_info '开始下载ApolloAdmin'
  wget -O apollo-adminservice.tar.gz $ADMIN_URL
  print_info '结束下载ApolloAdmin'

  print_info '开始解压ApolloAdmin'
  mkdir ./apollo-adminservice && tar -xzvf apollo-adminservice.tar.gz -C ./apollo-adminservice --strip-components 1
  print_info '结束解压ApolloAdmin'

  print_info '开始修改ApolloAdmin Config'
  apolloAdminConfigPath=$DATA_SERVER_PATH'apollo-adminservice/config/application-github.properties'
  sed -i -e "s#^spring.datasource.url=.*#spring.datasource.url=${MYSQL_CONFIG_URL}#g" ${apolloAdminConfigPath}
  sed -i -e "s#^spring.datasource.username=.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloAdminConfigPath}
  sed -i -e "s#^spring.datasource.password=.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloAdminConfigPath}
  print_info '结束修改ApolloAdmin Config'

  print_info '---------------- ApolloAdmin config ----------------'
  cat ${apolloAdminConfigPath}
  print_info '---------------- ApolloAdmin config ----------------'

  print_info '开始启动ApolloAdmin'
  sh ./apollo-adminservice/scripts/startup.sh > admin_start.log 2>&1
  print_info '结束启动ApolloAdmin'

  # -----------------------------------------------Apollo Portal----------------------------------------------------------------

  cd $DATA_SERVER_PATH
  print_info '开始下载ApolloPortal'
  wget $PORTAL_URL
  print_info '结束下载ApolloPortal'

  print_info '开始解压ApolloPortal'
  unzip apollo-portal-1.4.0\ 2.zip && mv `unzip -l apollo-portal-1.4.0\ 2.zip | awk '{if(NR == 4){ print $4}}'` apollo-portal
  print_info '结束解压ApolloPortal'

  print_info '开始修改ApolloPortal Config'
  apolloPortalConfigPath=$DATA_SERVER_PATH'apollo-portal/config/application-github.properties'
  sed -i -e "s#^spring.datasource.url=.*#spring.datasource.url=${MYSQL_PORTAL_URL}#g" ${apolloPortalConfigPath}
  sed -i -e "s#^spring.datasource.username=.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloPortalConfigPath}
  sed -i -e "s#^spring.datasource.password=.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloPortalConfigPath}
  print_info '结束修改ApolloPortal Config'

  print_info '---------------- ApolloPortal config ----------------'
  cat ${apolloPortalConfigPath}
  print_info '---------------- ApolloPortal config ----------------'

  print_info '开始修改ApolloPortal Meta Service'
  apolloPortalMetaPath=$DATA_SERVER_PATH'apollo-portal/config/apollo-env.properties'
  sed -i -e "s#^local.meta=.*#local.meta=${METAL_LOCAL}#g" ${apolloPortalMetaPath}
  sed -i -e "s#^dev.meta=.*#dev.meta=${META_DEV}#g" ${apolloPortalMetaPath}
  sed -i -e "s#^fat.meta=.*#fat.meta=${META_FAT}#g" ${apolloPortalMetaPath}
  sed -i -e "s#^uat.meta=.*#uat.meta=${META_UAT}#g" ${apolloPortalMetaPath}
  sed -i -e "s#^lpt.meta=.*#lpt.meta=${METAL_LOCAL}#g" ${apolloPortalMetaPath}
  sed -i -e "s#^pro.meta=.*#pro.meta=${META_PRO}#g" ${apolloPortalMetaPath}
  print_info '结束修改ApolloPortal Meta Service'

  print_info '---------------- ApolloPortal Meta Service ----------------'
  cat ${apolloPortalMetaPath}
  print_info '---------------- ApolloPortal Meta Service ----------------'

  print_info '开始启动ApolloPortal'
  sh ./apollo-portal/scripts/startup.sh > portal_start.log 2>&1
  print_info '结束启动ApolloPortal'
  print_info 'apollo 1.4 installing end'
}

function apollo1.6 {
  print_info 'apollo 1.6 installing begin'
  print_info 'apollo 1.6 installing end'
}

function apollo2.0 {
  print_info 'apollo 2.0 installing begin'
  print_info 'apollo 2.0 installing end'
}
