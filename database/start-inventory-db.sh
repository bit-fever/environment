#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-inventory-db"

runPodmanContainer(){
    if [[ $(podman ps --filter "name=^/$CONTAINER_NAME$" --format '{{.Names}}') == ${CONTAINER_NAME} ]]; then
        echo -n "Stopping old container : "
        podman stop ${CONTAINER_NAME}
    fi

    if [[ $(podman ps -a --filter "name=^/$CONTAINER_NAME$" --format '{{.Names}}') == ${CONTAINER_NAME} ]]; then
        echo -n "Removing old container : "
        podman rm ${CONTAINER_NAME}
    fi

    echo "Starting : $CONTAINER_NAME"

	podman run -d \
		--name ${CONTAINER_NAME} \
		--restart always \
		-e MYSQL_ROOT_PASSWORD=root \
		-v ${DIR}/inventory-db:/var/lib/mysql \
		-p 3400:3306 \
		docker://mysql:5.7

    if [[ $? == 0 ]]; then
        echo
        echo "Database running."
        echo
    fi
}

runPodmanContainer
