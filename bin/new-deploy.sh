RANCHER_STACK="$1"
RANCHER_COMPOSE_FILE=rancher-compose.yml
DOCKER_COMPOSE_FILE=docker-compose.yml
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.local/bin:../bin/
# Update stack on Rancher
#rancher-compose  --project-name ${RANCHER_STACK} rm --force
rancher-compose  --project-name ${RANCHER_STACK}  up -c -d --force-upgrade --pull
