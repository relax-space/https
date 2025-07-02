#!/bin/bash

PROJECT_DIR="/home/xxm/dockerpath/https/mmclue"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
IMAGE_NAME="jonasal/nginx-certbot"
LOG_FILE="$PROJECT_DIR/script/logs/mm_nginx_update.log"

cd "$PROJECT_DIR" || exit 1

echo "$(date '+%F %T') - 开始更新 $IMAGE_NAME" | tee -a "$LOG_FILE"

old_id=$(docker images -q "${IMAGE_NAME}:latest")

docker pull "$IMAGE_NAME" 2>&1 | tee -a "$LOG_FILE"

new_id=$(docker images -q "${IMAGE_NAME}:latest")

if [ "$old_id" != "$new_id" ]; then
  echo "$(date '+%F %T') - 镜像已更新，重启服务 ..." | tee -a "$LOG_FILE"
  
  docker-compose -f "$COMPOSE_FILE" down 2>&1 | tee -a "$LOG_FILE"
  docker-compose -f "$COMPOSE_FILE" up -d 2>&1 | tee -a "$LOG_FILE"
else
  echo "$(date '+%F %T') - 镜像未更新，无需重启" | tee -a "$LOG_FILE"
fi

echo "$(date '+%F %T') - 更新完成" | tee -a "$LOG_FILE"
