#!/bin/bash
# 日期时间
currentTime=`date +%Y-%m-%d-%H-%M-%S`

# 定义日志标识
FrankShell='[Frank Shell]'

# 绿色输出（正确）
echo_info() {
  echo "\033[30;32mINFO:\033[0m $FrankShell$currentTime $1"
}
