기존 방법

```sh
docker pull nginx:latest
```

```sh
docker run -it -p:18000:8000 --name my-nginx nginx:latest
```

 

docker-compose 실행

```yaml
version: "3.1"
services:
  my-webserver:
    platform: linux/arm64
    image: nginx:latest
    ports:
      - 81:80
```

```sh
docker-compose -f docker-compose1.yml up
```

docker-compose ps

```sh
docker-compose -f docker-compose1.yml ps
```

docker-compose 중지

```sh
docker-compose -f docker-compose1.yml down
```

------

docker-compose 실행 (mariaDB)

```yaml
version: "3.1"
services:
  my-db:
    platform: linux/arm64
    image: mariadb:latest
    environment:
      - MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true
      - MARIADB_DATABASE=mydb
    ports:
      - 13306:3306
    depends_on:
      - my-db
    volumes:
      - /Users/cg6jq7y05g/repository/study/getting-started-docker/docker-compose/data:/var/lib/mysql

```

```sh
docker-compose ./docker-compose2.yml up -d
```

* 네트워크 기본 설정을 하지 않은 경우 아래와 같은 경로로 네트워크가 잡힌다.

  * ```sh
    docker network ls
    NETWORK ID     NAME                     DRIVER    SCOPE
    899d3e2b33c9   bridge                   bridge    local
    26b6c5def742   docker-compose_default   bridge    local
    ee333830bae0   host                     host      local
    e3718c1da0c9   my-network               bridge    local
    2ab5eaa81d68   none                     null      local
    ```

* 현재 디렉토리의 이름을 따라간다.
  <img width="331" alt="image" src="https://github.com/user-attachments/assets/5028a702-dae7-4cde-837c-bfc814bc0d23">

docker-compose multi service 실행 (mariaDB, catalog-service)

```yaml
version: "3.1"
services:
  my-db:
    platform: linux/arm64
    image: mariadb:latest
    environment:
      - MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true
      - MARIADB_DATABASE=mydb
    ports:
      - 13306:3306
    volumes:
      - /Users/cg6jq7y05g/repository/study/getting-started-docker/docker-compose/data:/var/lib/mysql
    networks:
      - my-network

  my-backend:
    image: junwoo123/catalog-service:latest
    environment:
      - spring.datasource.url=jdbc:mariadb://my-db:3306/mydb
      - spring.datasource.password=
    ports:
      - 8088:8088
    depends_on:
      - my-db
    networks:
      - my-network

networks:
  my-network:
    external: true

```

```sh
docker-compose -f ./docker-compose3.yml up -d
```

* 확인
  
  * 컨테이너
  
  ```sh
  docker-compose -f ./docker-compose3.yml ps
  ```
  
  * 네트워크
  
  ```sh
  docker network inspect my-network
  
  "Containers": {
    "90d4b516c0f903cba81fed845d76320b5c7d1ef7e912f7465b77998435b2d182": {
        "Name": "docker-compose-my-backend-1",
        "EndpointID": "a2342cfece7dd69cea7eb793b9e7039cbb8b4a4da3f859e6dc5768a0ef14a5ed",
        "MacAddress": "02:42:ac:12:00:03",
        "IPv4Address": "172.18.0.3/16",
        "IPv6Address": ""
    },
    "c7db816ff363e9b6f30c7c26ce793ea991e6fb9c54828fa8f4e9ed66c998be35": {
        "Name": "docker-compose-my-db-1",
        "EndpointID": "3d91cbb0256dbab7a6fae9d0b17ccbc9bd0b979525accb6a07a1df4b5cca42bc",
        "MacAddress": "02:42:ac:12:00:02",
        "IPv4Address": "172.18.0.2/16",
        "IPv6Address": ""
    }
  }
  ```
  

docker-compose 로그 확인

* 전체로그
  ```sh
  docker-compose -f ./docker-compose3.yml logs
  ```

* 특정 서비스 로그
  ```sh
  docker-compose -f ./docker-compose3.yml logs my-backend
  ```

docker-compose multi service 실행 (mariaDB, catalog-service)

```yaml
version: "3.1"
services:
  my-db:
    platform: linux/arm64
    image: mariadb:latest
    environment:
      - MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true
      - MARIADB_DATABASE=mydb
    ports:
      - 13306:3306
    volumes:
      - /Users/cg6jq7y05g/repository/study/getting-started-docker/docker-compose/data:/var/lib/mysql
    networks:
      - my-network

  my-backend:
    image: junwoo123/catalog-service:latest
    environment:
      - spring.datasource.url=jdbc:mariadb://my-db:3306/mydb
      - spring.datasource.password=
    ports:
      - 8088:8088
    depends_on:
      - my-db
    networks:
      - my-network

  my-frontend:
    image: edowon0623/my-frontend:1.0
    ports:
      - 83:80
    depends_on:
      - my-db
    networks:
      - my-network

networks:
  my-network:
    external: true
```

```sh
docker-compose -f ./docker-compose4.yml up -d my-db
```

```sh
docker-compose -f ./docker-compose4.yml up -d
```

* depends on 을 설정하더라도 간혹 꼬이는 경우가 있기 때문에 my-db 먼저 실행
* http://localhost:83/ (frontend)
* http://localhost:8088/catalogs (backend)

