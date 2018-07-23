RANCHER_ENV="$1"
RANCHER_STACK="$2"
RANCHER_COMPOSE_FILE=rancher-compose.yml
DOCKER_COMPOSE_FILE=docker-compose.yml
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.local/bin:../bin/
# Update stack on Rancher
rancher --env ${RANCHER_ENV} up -d \
  --stack ${RANCHER_STACK} \
  --rancher-file ${RANCHER_COMPOSE_FILE} \
  --file ${DOCKER_COMPOSE_FILE} \
  --force-upgrade

# Confirm update on rancher
rancher --env ${RANCHER_ENV} up -d \
  --stack ${RANCHER_STACK} \
  --rancher-file ${RANCHER_COMPOSE_FILE} \
  --file ${DOCKER_COMPOSE_FILE} \
  --confirm-upgrade
