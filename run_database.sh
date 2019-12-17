#!/bin/bash


exec 2>&1
set -e
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

./kill_database.sh 2>&1

hasterm=''
if tty -s
then
	hasterm='-t'
fi

#**************
# Database
#**************
# FOR TESTING; forces complete container rebuild
cd dockerfiles/
# $CONTAINER_BIN build --no-cache -t sampre_jvs/jbovlaste_database -f Dockerfile.database .
$CONTAINER_BIN build -t sampre_jvs/jbovlaste_database --quiet=false -f Dockerfile.database . 2>&1 || {
  echo "Docker build failed."
  exit 1
}

$CONTAINER_BIN pod rm jbovlaste || true
$CONTAINER_BIN pod create --share=net -n jbovlaste -p 8380:8380

$CONTAINER_BIN run --pod jbovlaste --network slirp4netns --userns=keep-id --name jbovlaste_database \
	-v /home/sampre_jvs/jbovlaste/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=aos8iexai0sieYei \
	-e MYSQL_DATABASE=jbovlaste -e MYSQL_USER=jbovlaste -e MYSQL_PASSWORD=ohphoratee2neeCh \
	-i $hasterm sampre_jvs/jbovlaste_database 2>&1
