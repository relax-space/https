#!/bin/bash
# 获取脚本所在目录
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
# 执行 mm_nginx_update.sh 并记录日志
"$SCRIPT_DIR/mm_nginx_update.sh" >> "$SCRIPT_DIR/logs/auto_update.log" 2>&1
