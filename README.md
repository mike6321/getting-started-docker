# getting-started-docker
docker 스터디를 위한 repository 입니다.

------

### 도커 이미지 빌드

```sh
docker build --tag first-image:0.1 -f Dockerfile .
```

### 컨테이너 실행

```sh
docker run -it first-image:0.1 bash
```

