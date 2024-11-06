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

-it

* -i **(interactive)**: **표준 입력을 유지**하여 상호작용이 가능하게 합니다. 이 옵션을 통해 컨테이너 내부에서 사용자가 명령어를 입력할 수 있습니다.
  * ls 와 같은 명령을 쓸 수 있다. 
  * 사용하지 않는 경우 쓸 수 없다.

* -t **(tty)**: **TTY(Terminal)**를 할당하여, **터미널 세션을 활성화**합니다. 이를 통해 터미널 환경에서 컨테이너 내부의 명령어를 실행할 수 있으며, 결과가 보기 편한 터미널 형태로 출력됩니다.
  * 사용하지 않는 경우 내부로 진입 불가 

ex) docker run -it --network my-network ubuntu:16.04 bash
