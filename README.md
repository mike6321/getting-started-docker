# getting-started-docker
docker 스터디를 위한 repository 입니다.

------

### 도커 이미지 빌드

```sh
docker build -t first-image:0.1 -f Dockerfile .
```

### 컨테이너 실행

```sh
docker run -it first-image:0.1 bash
```

------

####  Docker를 이용한 가상화 시스템 구축

```sh
docker build -t nodejs-demo:v1.0 -f Dockerfile .
```

 ```sh
 docker run nodejs-demo 
 ```

```sh
docker exec -it 3567c30e20ff s
```

한줄

```sh
docker run -p 18000:8000 --name my-node nodejs-demo1:v1.0
```

------

### Registry Container 사용

```sh
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

* repository 목록 조회

```sh
curl http://localhost:5000/v2/_catalog
```

```sh
curl http://localhost:5000/v2/nodejs-demo/tags/list
```

* repository push

```sh
docker tag nodejs-demo:v1.0 localhost:5000/nodejs-demo:v1.0
```

```sh
docker push localhost:5000/nodejs-demo:v1.0
```

