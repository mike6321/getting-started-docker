기존 컨에이너 모두 종료

```sh
docker stop manager worker01 worker02
docker rm manager worker01 worker02
```

docker-compose-macos-apple.yml 기동

```sh
docker-compose -f ./docker-compose-macos-apple.yml up -d

NAME      IMAGE                         COMMAND                  SERVICE   CREATED         STATUS         PORTS
manager   edowon0623/docker-server:m1   "/sbin/init systemct…"   manager   2 minutes ago   Up 2 minutes   22/tcp, 3375/tcp, 0.0.0.0:9000->9000/tcp, 0.0.0.0:8000->80/tcp
worker1   edowon0623/docker-server:m1   "/sbin/init systemct…"   worker1   2 minutes ago   Up 2 minutes   22/tcp, 4789/udp, 7946/tcp, 7946/udp
worker2   edowon0623/docker-server:m1   "/sbin/init systemct…"   worker2   2 minutes ago   Up 2 minutes   22/tcp, 4789/udp, 7946/tcp, 7946/udp
```

* docker daemon 실행
  ```sh
  systemctl start docker
  ```

swarm 초기화 (manager node)
```sh
docker swarm init
```

swarm join (worker node)

```sh
docker swarm join --token SWMTKN-1-0kwvcv8kvfx5kvyknrcd324pla3dkvs1b6zzlbamg6fygp28ph-4tdbdyejfeoxbe4zh2t4sn3d6 172.19.0.2:2377
```

overlay network 생성 (manager node)

```sh
docker network create --driver overlay my-overlay-network
```

volume mount 설정하였던 stack 디렉토리 이동 (manager node)

```sh
cd /stack

[root@a52f397469c0 stack]# ls -l
total 8
-rw-r--r-- 1 root root 613 Nov 17 08:27 haproxy.cfg
-rw-r--r-- 1 root root 874 Nov 17 08:27 stack_sample.yml
```

stack 배포 (manager node)

* ngnix
* haproxy
  처음 기동시에는 ip 를 설정하면 안된다.

```sh
 docker stack deploy -c /stack/stack_sample.yml my-stack
```

```sh
docker stack ls
NAME       SERVICES   ORCHESTRATOR
my-stack   2          Swarm

docker stack services my-stack
ID             NAME             MODE         REPLICAS   IMAGE            PORTS
a332p0v3c9ft   my-stack_nginx   replicated   2/2        nginx:latest     *:8088->80/tcp
yef10p1ic74s   my-stack_proxy   global       0/0        haproxy:latest   *:80->80/tcp
```

접속 불가
: haproxy가 worker node 의 ip를 인식할 수 없기 때문에

worker1, worker2 의 nginx ip 주소확인

```sh
docker inspect 7d529a1342fe

10.0.0.6
10.0.1.4
```

* update
  ```sh
  docker service update --force my-stack_proxy
  ```

확인

http://localhost:8000/haproxy?stats

<img width="1886" alt="image" src="https://github.com/user-attachments/assets/08102ba5-e8dd-46c5-a647-33c7bba887d8">

동적으로 IP 할당 방법

```yaml
backend http_back
   balance roundrobin
   server-template app 2 nginx:80 check resolvers docker resolve-prefer ipv4
```

