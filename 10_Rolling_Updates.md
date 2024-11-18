현재 컨테이너 상태
```sh
CONTAINER ID   IMAGE                         COMMAND                  CREATED         STATUS         PORTS                                                            NAMES
62c18e7508af   edowon0623/docker-server:m1   "/sbin/init systemct…"   3 minutes ago   Up 3 minutes   22/tcp, 4789/udp, 7946/tcp, 7946/udp                             worker1
1b57e615d31c   edowon0623/docker-server:m1   "/sbin/init systemct…"   3 minutes ago   Up 3 minutes   22/tcp, 4789/udp, 7946/tcp, 7946/udp                             worker2
8db084e9c882   edowon0623/docker-server:m1   "/sbin/init systemct…"   3 minutes ago   Up 3 minutes   22/tcp, 3375/tcp, 0.0.0.0:9000->9000/tcp, 0.0.0.0:8000->80/tcp   manager
```

docker service  생성 (manager)

* 현재상태: swarm 이 초기화 되고 worker 노드가 manager 노드에 참여한 상태

```sh
docker service create --name myweb --replicas 3 nginx:latest
```

nginx 버전 downgrade (manager)

```sh
docker service update --image nginx:1.24 myweb
```

* 각각의 노드 버전 변경 확인
  ![image](https://github.com/user-attachments/assets/ae12b9fc-4d03-4d82-b0a2-5040734243c6)

새로운 docker service 생성 (manager)

```sh
docker service create --replicas 4 --name myweb2 --update-delay 10s --update-parallelism 2 nginx:latest
```

* 확인
  ```sh
  [root@8db084e9c882 ~]# docker service ps myweb2
  ID             NAME       IMAGE          NODE           DESIRED STATE   CURRENT STATE            ERROR     PORTS
  vkkdnen3nst9   myweb2.1   nginx:latest   8db084e9c882   Running         Running 39 seconds ago             
  l6qiudss0paf   myweb2.2   nginx:latest   62c18e7508af   Running         Running 39 seconds ago             
  hxftw0tg19kt   myweb2.3   nginx:latest   62c18e7508af   Running         Running 39 seconds ago             
  y0z1q481xm06   myweb2.4   nginx:latest   1b57e615d31c   Running         Running 39 seconds ago     
  ```

  * worker2에 (62c18e7508af) 두개의 nginx가 들어갔다.

nginx 버전 downgrade (manager)

```sh
docker service update --image nginx:1.24 myweb2
```

* 병렬 설정을 하였기 때문에 두개가 동시에 기동된다. 
  ```sh
  ID             NAME           IMAGE          NODE           DESIRED STATE   CURRENT STATE             ERROR     PORTS
  v7knpl7v47wm   myweb2.1       nginx:1.24     8db084e9c882   Running         Running 27 seconds ago              
  vkkdnen3nst9    \_ myweb2.1   nginx:latest   8db084e9c882   Shutdown        Shutdown 27 seconds ago             
  uv7ftuvk5qvf   myweb2.2       nginx:1.24     62c18e7508af   Running         Running 38 seconds ago              
  l6qiudss0paf    \_ myweb2.2   nginx:latest   62c18e7508af   Shutdown        Shutdown 39 seconds ago             
  sngrf96ebtp6   myweb2.3       nginx:1.24     62c18e7508af   Running         Running 38 seconds ago              
  hxftw0tg19kt    \_ myweb2.3   nginx:latest   62c18e7508af   Shutdown        Shutdown 39 seconds ago             
  lkug3ui61nfj   myweb2.4       nginx:1.24     1b57e615d31c   Running         Running 27 seconds ago              
  y0z1q481xm06    \_ myweb2.4   nginx:latest   1b57e615d31c   Shutdown        Shutdown 27 seconds ago
  ```

  
