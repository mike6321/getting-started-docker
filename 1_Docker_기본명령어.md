도커 이미지 빌드

```sh
docker build -t first-image:0.1 -f Dockerfile .
```

컨테이너 실행

```sh
docker run -it first-image:0.1 bash
```

------

Docker를 이용한 가상화 시스템 구축

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

------

이전에 사용했던 명령어 찾기

```sh
history | grep mariadb
```

start 와 run 의 차이	

* docker run: 새로운 컨테이너를 생성하고 실행합니다. 한 번 실행된 후 중지된 컨테이너를 재실행하려면 이 명령을 다시 사용할 수 없습니다.

* docker start: 중지된 컨테이너를 다시 시작할 때 사용합니다. 기존 컨테이너의 설정(포트, 환경 변수 등)을 유지하면서 재시작합니다.
