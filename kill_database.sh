#!/bin/bash

exec 2>&1
set -x

CONTAINER_BIN=${CONTAINER_BIN:-$(which podman)}
CONTAINER_BIN=${CONTAINER_BIN:-$(which docker)}

#**************
# Database
#**************
$CONTAINER_BIN stop --time=30 jbovlaste_database 2>&1
$CONTAINER_BIN kill jbovlaste_database 2>&1
$CONTAINER_BIN rm jbovlaste_database 2>&1

exit 0
