**볼륨 삭제**

* 전체 삭제

```sh
docker volume prune
```

* 특정 볼륨 삭제

```sh
docker volume rm [볼륨명]
```

**볼륨 정보 조회**

```sh
docker inspect [컨테이너명]
```

```json
"Mounts": [
    {
        "Type": "volume",
        "Name": "501daaf03621ccc4c3223f841ea867affdfd7e08f2dd66002fceb63be05bea4a",
        "Source": "/var/lib/docker/volumes/501daaf03621ccc4c3223f841ea867affdfd7e08f2dd66002fceb63be05bea4a/_data",
        "Destination": "/var/lib/mysql",
        "Driver": "local",
        "Mode": "",
        "RW": true,
        "Propagation": ""
    }
]
```

* Source: 외부 연결 저장소 (host pc)
* Destination: 내부 연결 저장소

**우분투 컨테이너 실행**

```sh
docker run -it --network my-network ubuntu:16.04 bash
```

