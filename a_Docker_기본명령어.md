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
docker build --tag nodejs-demo:v1.0 -f Dockerfile .
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
