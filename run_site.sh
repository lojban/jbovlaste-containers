#!/bin/bash

exec 2>&1
set -e
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

./kill_site.sh 2>&1

hasterm=''
if tty -s
then
	hasterm='-t'
fi

#**************
# Webserver
#**************

# FOR TESTING; forces complete container rebuild
# $CONTAINER_BIN build --no-cache -t sampre_jvs/jbovlaste_site -f Dockerfile.site .

cp httpd_glaukaba.conf dockerfiles/
cd dockerfiles/
$CONTAINER_BIN build -t sampre_jvs/jbovlaste_site -f Dockerfile.site . 2>&1 || {
  echo "Docker build failed."
  exit 1
}
$CONTAINER_BIN run -p 8380:8380 --pod jbovlaste --network slirp4netns --userns=keep-id --name jbovlaste_site \
	-v /home/sampre_jvs/jbovlaste/site:/srv/site -v /home/sampre_jvs/jbovlaste/src:/srv/src \
	-i $hasterm sampre_jvs/jbovlaste_site /usr/sbin/httpd -DFOREGROUND 2>&1
