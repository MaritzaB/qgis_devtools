#!/bin/bash

# 00 Create network
docker network create postgis_net
#######################################################################################################
#                                              DATABASES                                              #
#######################################################################################################

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

docker run -d -p 8081:8080 \
    --name geoserver \
    --volume=/home/maritzee/Documents/GitHub/qgis_devtools/geoserver_backup/geoserver_backup:/opt/geoserver/data_dir \
    --link postgis:postgis \
    --network=postgis_net \
    -e GEOSERVER_DATA_DIR=/opt/geoserver/data_dir \
    -e GEOSERVER_ADMIN_USER=admin \
    -e GEOSERVER_ADMIN_PASSWORD=geoserver \
    -e POSTGRES_PORT=5432 \
    -e POSTGRES_DB=metro_cdmx \
    -e POSTGRES_USER=admin \
	-e POSTGRES_PASSWORD=password \
    kartoza/geoserver:latest

# --volume geoserver_volume:/opt/geoserver/data_dir \
# cp geoserver_data/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml
