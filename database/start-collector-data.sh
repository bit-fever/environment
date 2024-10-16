#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-collector-data"

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
		-v ${DIR}/collector-data:/var/lib/postgresql/data \
		-p 3410:5432 \
		-e POSTGRES_PASSWORD=postgres \
		docker://timescale/timescaledb:2.17.0-pg16

    if [[ $? == 0 ]]; then
        echo
        echo "Database running."
        echo
    fi
}

runPodmanContainer
