#!/bin/bash
# 日期时间
currentTime=`date +%Y-%m-%d-%H-%M-%S`

# 定义日志标识
FrankShell='[Frank Shell]'

# 绿色输出（正确）
print_info() {
  echo "\033[30;32mINFO:\033[0m $FrankShell$currentTime $1"
}

# 批量创建文件，节省ES新增多表时单个文件依次创建所需时间，并将指定模版内容写入新建文件.
# $1：数组，文件名（通过数据库获取的表命名，格式：表名.yml）
# $2：指定目录
# frank_messages_0.yml修改参照的yml，更改个模版，写入到新建的文件中
touch_files_by_array() {
  array = $1
  for var in ${array[@]};
  do
    # 将指定yml的内容全部复制到新文件内
    cat /canal/client-adapter/launcher/src/main/resources/es7-message-center/frank_messages_0.yml > $2/$var
    # 修改文件中指定文本（这里是表名），替换为文件名（文件名就是对应数据库的表名）
    # 将文件$2/$var 中的table_name1替换成table_name_new
    sed -e 's/table_name1/table_name_new/' $2/$var
  done
}
