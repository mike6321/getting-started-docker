**볼륨(Volume)이란?**

**볼륨**은 Docker에서 컨테이너가 사용하는 데이터를 **컨테이너 외부에 저장하는** 메커니즘입니다. 볼륨은 Docker 엔진에 의해 관리되며, 컨테이너가 삭제되어도 볼륨에 저장된 데이터는 유지됩니다. 볼륨을 사용하면 여러 컨테이너가 데이터를 공유하거나, 컨테이너의 데이터를 지속적으로 보존할 수 있습니다.

**볼륨의 주요 특징**

* **데이터 지속성**: 컨테이너가 삭제되더라도 볼륨에 저장된 데이터는 남아 있습니다.

* **컨테이너 간 데이터 공유**: 여러 컨테이너가 동일한 볼륨을 참조할 수 있습니다.

* **독립성**: 볼륨은 Docker 엔진에서 관리되므로, 호스트의 파일 시스템 경로와 독립적으로 데이터를 관리할 수 있습니다.

**마운트(Mount)란?**

**마운트**는 **컨테이너의 특정 경로에 외부 저장소를 연결**하는 작업을 의미합니다. 마운트를 통해 Docker 볼륨이나 호스트 디렉토리를 컨테이너의 특정 경로에 연결하여 데이터를 저장하고 불러올 수 있습니다.

------

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
docker run -it --network my-network --name my-ubuntu ubuntu:16.04 bash
```

**우분투 컨테이너 mount 조회**

```json
"Mounts": []
```

* 없음

볼륨 생성

```sh
docker volume create my-volume
```

우분투 볼륨 연결

```sh
docker run --rm -it --network my-network --volume my-volume:/app/test --name my-ubuntu ubuntu:16.04
```

* /app/test 디렉토리 연결

<img width="599" alt="image" src="https://github.com/user-attachments/assets/991cc93a-7d6b-409b-87ae-d26fb357d9de">	

/app/test 에 간단한 파일 작성

```sh
echo "Hello World!" >> junwoo.txt
```

볼륨 상세 조회

```sh
docker volume inspect my-volum
```

```json
[
    {
        "CreatedAt": "2024-11-06T14:09:40Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my-volume/_data",
        "Name": "my-volume",
        "Options": null,
        "Scope": "local"
    }
]
```

Mac 사용환경에서는 /var/lib/docker/volumes/my-volume/_data 디렉토리로 직접적으로 이동 불가

busybox 컨테이너 실행

```sh
docker run --rm -it --volume my-volume:/app busybox sh
```

우분투 환경에서 만들었던 junwoo.txt 파일 존재 확인

![image-20241106232742224](/Users/cg6jq7y05g/Library/Application Support/typora-user-images/image-20241106232742224.png)

# 
