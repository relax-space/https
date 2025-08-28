#!/bin/bash
# 获取脚本所在目录
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
# 项目根目录
PROJECT_DIR="$SCRIPT_DIR/.."
# 其他路径
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
IMAGE_NAME="jonasal/nginx-certbot"
LOG_FILE="$SCRIPT_DIR/logs/mm_nginx_update.log"

cd "$PROJECT_DIR" || exit 1

echo "$(date '+%F %T') - 开始更新 $IMAGE_NAME" | tee -a "$LOG_FILE"

# 获取当前镜像 ID
old_id=$(docker images -q "${IMAGE_NAME}:latest")

# 拉取最新镜像
docker pull --no-cache "$IMAGE_NAME" 2>&1 | tee -a "$LOG_FILE"

# 获取新镜像 ID
new_id=$(docker images -q "${IMAGE_NAME}:latest")

if [ "$old_id" != "$new_id" ]; then
  echo "$(date '+%F %T') - 镜像已更新，重启服务 ..." | tee -a "$LOG_FILE"
  
  # 重启服务, 不修改compose.yml时,不需要down
  # docker-compose -f "$COMPOSE_FILE" down 2>&1 | tee -a "$LOG_FILE"
  docker-compose -f "$COMPOSE_FILE" up -d --force-recreate 2>&1 | tee -a "$LOG_FILE"

  # 清理无标签的旧镜像
  echo "$(date '+%F %T') - 清理无标签的旧镜像 ..." | tee -a "$LOG_FILE"
  docker image prune -f 2>&1 | tee -a "$LOG_FILE"
else
  echo "$(date '+%F %T') - 镜像未更新，无需重启" | tee -a "$LOG_FILE"
fi

echo "$(date '+%F %T') - 更新完成" | tee -a "$LOG_FILE"
