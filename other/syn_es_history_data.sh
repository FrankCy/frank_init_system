#!/bin/bash
# ES历史数据同步
# array：需要同步的yaml
array=(name_1.yml name_2.yml name_3.yml name_4.yml name_5.yml name_6.yml)
# etl的URL，指定索引，环境
target_url=http://127.0.0.1:11113/etl/es7/index_hw-test/
for var in ${array[@]};
do
  curl -X POST $target_url$var
done