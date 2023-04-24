#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-inventory-db"

runDockerContainer(){
    if [[ $(docker ps --filter "name=^/$CONTAINER_NAME$" --format '{{.Names}}') == ${CONTAINER_NAME} ]]; then
        echo -n "Stopping old container : "
        docker stop ${CONTAINER_NAME}
    fi

    if [[ $(docker ps -a --filter "name=^/$CONTAINER_NAME$" --format '{{.Names}}') == ${CONTAINER_NAME} ]]; then
        echo -n "Removing old container : "
        docker rm ${CONTAINER_NAME}
    fi

    echo "Starting : $CONTAINER_NAME"

	docker run -d \
		--name ${CONTAINER_NAME} \
		--restart always \
		-e MYSQL_ROOT_PASSWORD=root \
		-v ${DIR}/inventory-db:/var/lib/mysql \
		-p 3400:3306 \
		mysql:5.7

    if [[ $? == 0 ]]; then
        echo
        echo "Database running."
        echo
    fi
}

runDockerContainer
