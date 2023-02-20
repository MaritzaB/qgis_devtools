#!/bin/bash

# Crea una base de datos con POSTGIS con los parámetros necesarios para
# conectarse desde DBeaver

# 01 Create a network
docker network create postgis_net

# 02 Run postgis container and create postgres database

docker run -d \
    --name postgis01 \
    --network="postgis_net" \
    -e POSTGRES_USER=admin \
	-e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=metro_cdmx \
    -p 5432:5432 \
	postgres

#03 Run pgadmin container for visualizing database

docker run -d -p 8080:80 \
    --network="postgis_net" \
    -e PG_ADMIN_DEFAULT_EMAIL=admin@gmail.com \
    -e PG_ADMIN_DEFAULT_PASSWORD=pgadmin_password \
    dpage/pgadmin4
