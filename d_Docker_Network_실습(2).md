MariaDB 컨테이너 생성

```sh
docker run -d -p 13306:3306 \
        -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true \
        -e MARIADB_DATABASE=mydb \
        --name my-mariadb \
        mariadb:latest
```

