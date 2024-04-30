#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-rabbitmq"

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
		--hostname bitfever \
		-p 8451:15672 \
		-p 8450:5672 \
		-e RABBITMQ_DEFAULT_USER=rabbit-admin \
		-e RABBITMQ_DEFAULT_PASS=rabbit.admin \
		rabbitmq:3.12.10-management

    if [[ $? == 0 ]]; then
        echo
        echo "Message queue running."
        echo
    fi
}

runDockerContainer
