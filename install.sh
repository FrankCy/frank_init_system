#!/bin/bash
#-------------------------------------------------#
# 脚本主要功能说明:
#-------------------------------------------------#
. common/common.sh
. initapp/java.sh
. initapp/maven.sh
print_info '开始安装'
# 传递参数
print_info  '----------------------------------------------------------------'
#maven3_6
print_info '安装结束'

print_info '循环创建文件'
array=(merchant_order_2401_0.yml merchant_order_2401_1.yml merchant_order_2401_2.yml merchant_order_2402_0.yml merchant_order_2402_1.yml merchant_order_2402_2.yml merchant_order_2403_0.yml merchant_order_2403_1.yml merchant_order_2403_2.yml merchant_order_2404_0.yml merchant_order_2404_1.yml merchant_order_2404_2.yml merchant_order_2405_0.yml merchant_order_2405_1.yml merchant_order_2405_2.yml merchant_order_2406_0.yml merchant_order_2406_1.yml merchant_order_2406_2.yml merchant_order_2407_0.yml merchant_order_2407_1.yml merchant_order_2407_2.yml merchant_order_2408_0.yml merchant_order_2408_1.yml merchant_order_2408_2.yml merchant_order_2409_0.yml merchant_order_2409_1.yml merchant_order_2409_2.yml merchant_order_2410_0.yml merchant_order_2410_1.yml merchant_order_2410_2.yml merchant_order_2411_0.yml merchant_order_2411_1.yml merchant_order_2411_2.yml merchant_order_2412_0.yml merchant_order_2412_1.yml merchant_order_2412_2.yml merchant_order_2501_0.yml merchant_order_2501_1.yml merchant_order_2501_2.yml merchant_order_2502_0.yml merchant_order_2502_1.yml merchant_order_2502_2.yml merchant_order_2503_0.yml merchant_order_2503_1.yml merchant_order_2503_2.yml merchant_order_2504_0.yml merchant_order_2504_1.yml merchant_order_2504_2.yml merchant_order_2505_0.yml merchant_order_2505_1.yml merchant_order_2505_2.yml merchant_order_2506_0.yml merchant_order_2506_1.yml merchant_order_2506_2.yml merchant_order_2507_0.yml merchant_order_2507_1.yml merchant_order_2507_2.yml merchant_order_2508_0.yml merchant_order_2508_1.yml merchant_order_2508_2.yml merchant_order_2509_0.yml merchant_order_2509_1.yml merchant_order_2509_2.yml merchant_order_2510_0.yml merchant_order_2510_1.yml merchant_order_2510_2.yml merchant_order_2511_0.yml merchant_order_2511_1.yml merchant_order_2511_2.yml merchant_order_2512_0.yml merchant_order_2512_1.yml merchant_order_2512_3.yml)
touch_files_by_array array /Users/cy/project-shell/frank_init_system
print_info '循环创建文件结束'
