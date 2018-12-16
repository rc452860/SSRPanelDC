#!/bin/bash
PASSWORD=root
sed "s/MYSQL_ROOT_PASSWORD=password/MYSQL_ROOT_PASSWORD=$PASSWORD/g"  docker-compose.yml -i
docker-compose up -d
echo -e "---> Starting MySQL docker container..."
docker_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps  --filter Name=mysql -q))

echo -e "---> Waiting for MySQL to start on 3306..."
while ! nc -z $docker_ip 3306; do
    sleep 1
    printf "."
done
echo ""
echo -e "---> MySQL Started."
docker-compose exec -T mysql mysql -h127.0.0.1 -uroot -p${PASSWORD} -e "create database ssrpanel"
docker-compose exec -T mysql mysql  -h127.0.0.1 -uroot -p${PASSWORD} ssrpanel < ../web/src/SSRPanel/sql/db.sql

