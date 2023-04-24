#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-collector-data"

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
		-e DOCKER_INFLUXDB_INIT_MODE=setup \
		-e DOCKER_INFLUXDB_INIT_USERNAME=bitfever \
		-e DOCKER_INFLUXDB_INIT_PASSWORD=bitfever \
		-e DOCKER_INFLUXDB_INIT_ORG=BitFever \
		-e DOCKER_INFLUXDB_INIT_BUCKET=symbol-data \
		-e DOCKER_INFLUXDB_INIT_RETENTION=8000d \
		-e DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=xdtSqXm2-9Sl7_dpnXx5yQqEbglhklw3KRQDd_0Zj-Vyo-x0sjxbCI4K_wbtyq_xzbn9I4xd9KzAZd7vYlORIQ== \
		-v ${DIR}/collector-data/config:/etc/influxdb2 \
		-v ${DIR}/collector-data/data:/var/lib/influxdb2 \
		-p 8051:8086 \
		influxdb:2.3.0

    if [[ $? == 0 ]]; then
        echo
        echo "Database running."
        echo
    fi
}

runDockerContainer
