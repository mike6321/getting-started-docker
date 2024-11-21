mariadb pull

```sh
docker pull mariadb:latest
```

mariadb run

```sh
docker run -d -p 3305:3305 -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true --name my-m
ariadb mariadb:latest
```

log path 확인

```sh
docker inspect f7a7c013e5a0 | grep log

"LogPath": "/var/lib/docker/containers/f7a7c013e5a0f2aaf365d0c272e98bd2d5b68b7d9458f7efa8c735a77331dd72/f7a7c013e5a0f2aaf365d0c272e98bd2d5b68b7d9458f7efa8c735a77331dd72-json.log"
```

log 확인

```sh
cat /var/lib/docker/containers/f7a7c013e5a0f2aaf365d0c272e98bd2d5b68b7d9458f7efa8c735a77331dd72/f7a7c013e5a0f2aaf365d0c272e98bd2d5b68b7d9458f7efa8c735a77331dd72-json.log
```

docker log 확인

```sh
docker logs f7a7c013e5a0
```

![image](https://github.com/user-attachments/assets/7e442dab-be68-41e7-911c-c36d6a070ae3)

syslog 추가

```sh
docker run -d -p 3305:3305 --log-driver syslog -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true --name my-mariadb mariadb:latest
```

syslog 조회

```sh
journalctl -u docker.service | grep 6b236922f746
```

