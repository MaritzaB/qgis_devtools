#!/bin/bash

# 00 Create network
docker network create postgis_net

# 01 Run postgis container and create postgres database

docker run -itd \
    --name postgis \
    --volume=postgis_volume:/postgis_volume \
    --network=postgis_net \
    -e POSTGRES_USER=admin \
	-e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=metro_cdmx \
    -p 5432:5432 \
	postgis/postgis

#03 Run GeoServer with Docker

docker run -d -p 80:8080 \
    --name geoserver \
    --volume=geoserver_volume:/geoserver_data \
    --network=postgis_net \
    -e GEOSERVER_USER=admin \
    -e GEOSERVER_PASSWORD=geoserver \
    docker.osgeo.org/geoserver:2.22.0


