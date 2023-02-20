#!/bin/bash

# Crea una base de datos e POSTGRES con los parámetros necesarios para
# conectarse desde DBeaver

docker run -d \
    --name postgresTest01 \
    -e POSTGRES_USER=admin \
	-e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=metro_cdmx \
    -p 5432:5432 \
	postgres