#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明: Apollo
#-------------------------------------------------#
echo 'apollo 1.4 installing begin'
CONFIG_URL=#
ADMIN_URL=#
PORTAL_URL=#

# portal meta service配置，自行修改
METAL_LOCAL=http://localhost:8077
META_DEV=http://localhost:8077
META_FAT=http://localhost:8077
META_UAT=http://localhost:8077
META_LPT=http://localhost:8077
META_PRO=http://localhost:8077

# 数据库配置
MYSQL_CONFIG_URL=jdbc:mysql://10.100.64.154:3306/apollo_config_db?characterEncoding=utf8
MYSQL_PORTAL_URL=jdbc:mysql://10.100.64.154:3306/apollo_portal_db?characterEncoding=utf8
MYSQL_USER=root
MYSQL_PASSWORD=root

#如果文件夹不存在，则创建文件夹
DATA_SERVER_PATH="/data/server/"
if [ ! -d "$DATA_SERVER_PATH" ]; then
  mkdir $DATA_SERVER_PATH
else
  echo '文件夹已存在'
  echo '进入文件夹'
  cd $DATA_SERVER_PATH
fi
# -----------------------------------------------Apollo Config----------------------------------------------------------------
echo '开始下载ApolloConfig'
wget $CONFIG_URL
echo '结束下载ApolloConfig'

echo '开始解压ApolloConfig'
unzip apollo-configservice-1.6.1-github.zip -d apollo-configservice
echo '结束解压ApolloConfig'

echo '开始修改ApolloConfig config'
apolloConfigConfigPath=$DATA_SERVER_PATH'apollo-configservice/config/application-github.properties'
sed -i -e "s#^spring.datasource.url =.*#spring.datasource.url=${MYSQL_CONFIG_URL}#g" ${apolloConfigConfigPath}
sed -i -e "s#^spring.datasource.username =.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloConfigConfigPath}
sed -i -e "s#^spring.datasource.password =.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloConfigConfigPath}
echo '结束修改ApolloConfig config'

echo '---------------- ApolloConfig config ----------------'
cat ${apolloConfigConfigPath}
echo '---------------- ApolloConfig config ----------------'

echo '开始启动ApolloConfig'
nohup bash ./apollo-configservice/scripts/startup.sh > config_start.log &
echo '结束启动ApolloConfig'

# -----------------------------------------------Apollo Admin----------------------------------------------------------------

cd $DATA_SERVER_PATH
echo '开始下载ApolloAdmin'
wget $ADMIN_URL
echo '结束下载ApolloAdmin'

echo '开始解压ApolloAdmin'
unzip apollo-adminservice.tar.gz -d apollo-adminservice
echo '结束解压ApolloAdmin'

echo '开始修改ApolloAdmin Config'
apolloAdminConfigPath=$DATA_SERVER_PATH'apollo-adminservice/config/application-github.properties'
sed -i -e "s#^spring.datasource.url =.*#spring.datasource.url=${MYSQL_CONFIG_URL}#g" ${apolloAdminConfigPath}
sed -i -e "s#^spring.datasource.username =.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloAdminConfigPath}
sed -i -e "s#^spring.datasource.password =.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloAdminConfigPath}
echo '结束修改ApolloAdmin Config'

echo '---------------- ApolloAdmin config ----------------'
cat ${apolloAdminConfigPath}
echo '---------------- ApolloAdmin config ----------------'

echo '开始启动ApolloAdmin'
nohup bash ./apollo-adminservice/scripts/startup.sh > admin_start.log &
echo '结束启动ApolloAdmin'

# -----------------------------------------------Apollo Portal----------------------------------------------------------------

cd $DATA_SERVER_PATH
echo '开始下载ApolloPortal'
wget $PORTAL_URL
echo '结束下载ApolloPortal'

echo '开始解压ApolloPortal'
unzip apollo-portal-1.6.1-github.zip -d apollo-portal
echo '结束解压ApolloPortal'

echo '开始修改ApolloPortal Config'
apolloPortalConfigPath=$DATA_SERVER_PATH'apollo-portal/config/application-github.properties'
sed -i -e "s#^spring.datasource.url =.*#spring.datasource.url=${MYSQL_PORTAL_URL}#g" ${apolloPortalConfigPath}
sed -i -e "s#^spring.datasource.username =.*#spring.datasource.username=${MYSQL_USER}#g" ${apolloPortalConfigPath}
sed -i -e "s#^spring.datasource.password =.*#spring.datasource.password=${MYSQL_PASSWORD}#g" ${apolloPortalConfigPath}
echo '结束修改ApolloPortal Config'

echo '---------------- ApolloPortal config ----------------'
cat ${apolloPortalConfigPath}
echo '---------------- ApolloPortal config ----------------'

echo '开始修改ApolloPortal Meta Service'
apolloPortalMetaPath=$DATA_SERVER_PATH'apollo-portal/config/apollo-env.properties'
sed -i -e "s#^local.meta=.*#local.meta=${METAL_LOCAL}#g" ${apolloPortalMetaPath}
sed -i -e "s#^dev.meta=.*#dev.meta=${META_DEV}#g" ${apolloPortalMetaPath}
sed -i -e "s#^fat.meta=.*#fat.meta=${META_FAT}#g" ${apolloPortalMetaPath}
sed -i -e "s#^uat.meta=.*#uat.meta=${META_UAT}#g" ${apolloPortalMetaPath}
sed -i -e "s#^lpt.meta=.*#lpt.meta=${METAL_LOCAL}#g" ${apolloPortalMetaPath}
sed -i -e "s#^pro.meta=.*#pro.meta=${META_PRO}#g" ${apolloPortalMetaPath}
echo '结束修改ApolloPortal Meta Service'

echo '---------------- ApolloPortal Meta Service ----------------'
cat ${apolloPortalMetaPath}
echo '---------------- ApolloPortal Meta Service ----------------'

echo '开始启动ApolloPortal'
nohup bash ./apollo-portal/scripts/startup.sh > portal_start.log &
echo '结束启动ApolloPortal'
echo 'apollo 1.4 installing end'

