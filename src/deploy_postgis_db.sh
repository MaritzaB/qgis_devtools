#!/bin/bash

# Crea una base de datos con POSTGIS con los parámetros necesarios para
# conectarse desde DBeaver

# 01 Create a network
docker network create postgis_net

# 02 Run postgis container and create postgres database

docker run -d \
    --name postgis01 \
    --network=postgis_net \
	-e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=metro_cdmx \
    -p 5432:5432 \
	postgis/postgis

#03 Run pgadmin container for visualizing database

docker run -d -p 8080:80 \
    --name pgadmin \
    --network=postgis_net \
    -e PGADMIN_DEFAULT_EMAIL=admin@gmail.com \
    -e PGADMIN_DEFAULT_PASSWORD=pgadmin_password \
    dpage/pgadmin4

