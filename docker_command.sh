 docker network create --driver bridge my-network

docker run -d -p 13306:3306 \
        -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true \
        -e MARIADB_DATABASE=mydb \
        --name my-mariadb \
        junwoo123/my-mariadb:latest

docker run -d -p 8088:8088 --network my-network \
        -e "spring.datasource.url=jdbc:mariadb://my-mariadb:3306/mydb" \
        --name catalog-service junwoo123/catalog-service:latest


