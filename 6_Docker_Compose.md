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

