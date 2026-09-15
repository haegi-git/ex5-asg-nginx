#!/bin/bash
set -e

dnf install -y docker
systemctl enable --now docker

mkdir -p /usr/libexec/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64 \
  -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

until docker info >/dev/null 2>&1; do
  sleep 2
done

# / 에 compose 를 두면 프로젝트 이름이 비어서 up 실패. app 폴더 + -p nginx
mkdir -p /home/ec2-user/nginx/html /home/ec2-user/nginx/logs /home/ec2-user/app
chown -R ec2-user:ec2-user /home/ec2-user/nginx /home/ec2-user/app

aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 925047940866.dkr.ecr.eu-central-1.amazonaws.com

aws s3 sync s3://std11-test-bucket/nginx/html/ /home/ec2-user/nginx/html/
aws s3 cp s3://std11-test-bucket/docker-compose.yaml /home/ec2-user/app/docker-compose.yaml

docker compose -p nginx -f /home/ec2-user/app/docker-compose.yaml pull
docker compose -p nginx -f /home/ec2-user/app/docker-compose.yaml up -d --remove-orphans
docker image prune -f
