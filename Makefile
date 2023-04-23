volumes:
	docker volume create --name=postgis_volume
	docker volume create --name=geoserver_volume

network:
	docker network create postgis_net

clean:
	docker stop $(shell docker ps -aq)
	docker rm $(shell docker ps -aq)
	docker network rm postgis_net

deploy:
	./src/deploy_postgis_db.sh

dump:
	docker exec -t postgis pg_dump metro_cdmx \
	--clean --username=admin --no-password \
	> $(HOME)/Documents/GitHub/qgis_devtools/database/dump_metro_cdmx.sql

# Es necesario hacer el `make restore` cada vez que levantemos los contenedores,
# de lo contrario, el geoserver no encontrará los datos de las capas (layers).

restore:
	cat $(HOME)/Documents/GitHub/qgis_devtools/database/dump_metro_cdmx.sql \
	| docker exec -i postgis psql --username=admin --table= denue_inegi_09_ --dbname=metro_cdmx 
