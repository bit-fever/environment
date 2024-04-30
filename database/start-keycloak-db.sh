#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-keycloak-db"

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
		-e MYSQL_USER=admin \
		-e MYSQL_PASSWORD=password.123 \
		-e MYSQL_DATABASE=keycloak \
		-v ${DIR}/keycloak-db:/var/lib/mysql \
		-p 3403:3306 \
		mysql:5.7

    if [[ $? == 0 ]]; then
        echo
        echo "Database running."
        echo
    fi
}

runDockerContainer
