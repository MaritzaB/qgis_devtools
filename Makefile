volumes:
	docker volume create --name=postgis_volume
	docker volume create --name=geoserver_data

network:
	docker network create postgis_net

clean:
	docker stop $(shell docker ps -aq)
	docker rm $(shell docker ps -aq)
	docker network rm postgis_net

deploy:
	./src/deploy_postgis_db.sh

dump:
	docker exec -t postgis pg_dumpall \
	-c --username=admin --no-password \
	> /home/usuario/Documents/GitHub/qgis_devtools/database/dump_metro_cdmx.sql

restore:
	cat /home/usuario/Documents/GitHub/qgis_devtools/database/dump_metro_cdmx.sql \
	| docker exec -i postgis psql --username=admin --dbname=metro_cdmx

    #--volume=geoserver_data:/opt/geoserver/data/dir \