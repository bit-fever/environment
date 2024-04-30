#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
CONTAINER_NAME="bitfever-keycloak"

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
		-e KEYCLOAK_ADMIN=keycloak-admin \
		-e KEYCLOAK_ADMIN_PASSWORD=keycloak#admin \
		-e KC_DB=mysql \
		-e KC_DB_URL=jdbc:mysql://192.168.1.100:3403/keycloak?serverTimezone=UTC \
		-e KC_DB_USERNAME=admin \
		-e KC_DB_PASSWORD=password.123 \
        -v ${DIR}/config:/config \
		-p 8448:8443 \
        quay.io/keycloak/keycloak:24.0.3 \
		start	--https-certificate-file=/config/server.crt \
				--https-certificate-key-file=/config/server.key \
				--hostname-url=https://bitfever-server:8443/auth \
				--hostname-admin-url=https://bitfever-server:8443/auth \
				--proxy=reencrypt

    if [[ $? == 0 ]]; then
        echo
        echo "Keycloak running."
        echo
    fi
}

runDockerContainer
#				--hostname-strict=false \
