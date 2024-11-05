MariaDB 컨테이너 생성

```sh
docker run -d -p 13306:3306 \
        -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true \
        -e MARIADB_DATABASE=mydb \
        --name my-mariadb \
        mariadb:latest
```

네트워크 생성

```sh
docker network create --driver bridge my-network
```

* 확인
  * bridge : 172.17.0.1
  * my-network: 172.18.0.1

```sh
docker network inspect my-network
```

MariaDB Registry push

* 태그생성

```sh
docker tag mariadb:latest junwoo123/my-mariadb:latest
```

* push

```sh
docker push junwoo123/my-mariadb
```

MariaDB 컨테이너 생성

* my-network 에 연결하여 생성

```sh
docker run -d -p 13306:3306 --network my-network\
        -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true \
        -e MARIADB_DATABASE=mydb \
        --name my-mariadb \
        junwoo123/my-mariadb:latest
```

```json
"Containers": {
    "12e5f60ccbb2efbf5708c6d819016566a964ece24a739a2eeb06708397076847": {
        "Name": "my-mariadb",
        "EndpointID": "c89fdb617a197878eaa4dc75ddf98685252603b551826dd9f9d4cea86db5df9f",
        "MacAddress": "02:42:ac:12:00:02",
        "IPv4Address": "172.18.0.2/16",
        "IPv6Address": ""
    }
}
```

back-end service build

```sh
docker build -t catalog-service:mariadb-demo -f Dockerfile .
```

* 태그생성

```sh
docker tag catalog-service:mariadb-demo junwoo123/catalog-service
```

* push

```sh
docker push junwoo123/catalog-service
```

back-end service 컨테이너 생성

* my-network 에 연결하여 생성

```sh
docker run -d -p 8088:8088 --network my-network \
        -e "spring.datasource.url=jdbc:mariadb://my-mariadb:3306/mydb" \
        --name catalog-service junwoo123/catalog-service:latest
```

```json
"4b8e893ad9480b1347cf5fb6bed8df1d2bedfc07d376ce95eadb1c866cce0e93": {
  "Name": "catalog-service",
  "EndpointID": "cfe18ab849059bd6237776b3822b3b12761b2d7d647a3e9cf41196378fbec2b5",
  "MacAddress": "02:42:ac:12:00:03",
  "IPv4Address": "172.18.0.3/16",
  "IPv6Address": ""
}
```

* 확인

http://localhost:8088/catalogs

<img width="811" alt="image" src="https://github.com/user-attachments/assets/ff0db5ce-c118-4cb3-88e8-01acbaec15b0">

