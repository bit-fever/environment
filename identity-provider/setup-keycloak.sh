#!/bin/bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"

docker run \
		--name keycloak-setup \
		-e KC_DB=mysql \
		-e KC_DB_URL=jdbc:mysql://192.168.1.100:3403/keycloak?serverTimezone=UTC \
		-e KC_DB_USERNAME=admin \
		-e KC_DB_PASSWORD=password.123 \
        -v ${DIR}/config:/opt/keycloak/data/import \
		-p 8080:8080 \
        quay.io/keycloak/keycloak:24.0.3 \
        start-dev --import-realm
