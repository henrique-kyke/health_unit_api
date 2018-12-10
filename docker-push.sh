#!/bin/bash
TAG=`git describe --tags`
echo "Changing ECS Config to health_unit_api as Default"

sed -i -e 's/default\:.*/default\:\ health_unit_api/g' ~/.ecs/config

echo "Login"

`aws ecr get-login --no-include-email --region us-east-1 --profile health_unit_api`

echo "Building"

docker build . -t health_unit_api

echo "Taging"

# docker tag health_unit_api-repo:latest 350051697926.dkr.ecr.us-east-1.amazonaws.com/health_unit_api:$TAG
docker tag health_unit_api:latest 350051697926.dkr.ecr.us-east-1.amazonaws.com/health_unit_api:latest

echo "Pushing"

# docker push 350051697926.dkr.ecr.us-east-1.amazonaws.com/health_unit_api:$TAG
docker push 350051697926.dkr.ecr.us-east-1.amazonaws.com/health_unit_api:latest

echo "Updating"

ecs-cli compose \
  --file docker-compose.yml \
  --project-name health_unit_api service up \
  --ecs-profile health_unit_api \
  --container-name health_unit_api \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:350051697926:targetgroup/health-unit-tg/c4f760a60026e4c6 \
  --container-port 80 \
  --force-deployment \
  --create-log-groups
