docker service는 Swarm 모드에서 **컨테이너를 배포하고 스케일링**하기 위해 사용됩니다. Swarm 모드에서 단순한 docker run 명령어 대신 docker service를 사용하여 애플리케이션을 배포하면, Docker가 **자동으로 클러스터 내의 노드에 컨테이너를 할당**하고, **자동 복구 및 스케일링** 기능을 제공합니다.

* mangager node가 있고 worker 노드가 2개 있다고 가정
  * service replicas 3 으로 기동하면 세개의 노드 모드 컨테이너가 생성된다.

```sh
# replicas update명령어
docker service update --replicas [service_name]

# service 확인 명령어 (간소화)
docker service ls
# service 확인 명령어 (디테일)
docker service ps [service_name]
```



노드 목록 확인

```sh
[root@5ef6c7c6903b ~]# docker node ls

ID                            HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
0gxb2xwznfurcyaa2tprkub4s     0fec15aadeef   Ready     Active                          20.10.17
wcggf1rxr1a0k1kgrvtj9prx8 *   5ef6c7c6903b   Ready     Active         Leader           20.10.17
waisqp96n8fv1ybp23rvmeayb     778fd17c6129   Ready     Active                          20.10.17
```

서비스 생성
```sh
[root@5ef6c7c6903b ~]# docker service create --replicas 1 --publish  80:80 --name my-nginx nginx:latest

ID             NAME       MODE         REPLICAS   IMAGE          PORTS
lsjwsnbaqm3t   my-nginx   replicated   1/1        nginx:latest   *:80->80/tcp
```

![image](https://github.com/user-attachments/assets/f1eb63bd-7e3b-4b4d-b479-7f2fadb459c3)

* 리더 노드에만 컨테이너 생성된 것 확인

스케일 업

```sh
[root@5ef6c7c6903b ~]# docker service scale my-nginx=3
```

* 3개의 컨테이너 생성

![image](https://github.com/user-attachments/assets/e002146e-43e9-4bb9-bc76-ee2207189315)

* worker node에 분포된 것 확인

worker node 3 nginx 컨테이너 삭제
```sh
[root@0fec15aadeef ~]# docker stop b1a225ae4388
[root@0fec15aadeef ~]# docker rm b1a225ae4388
```

* 삭제했음에도 불구하고 새로운 컨테이너 자동 생성
  ```sh
  [root@0fec15aadeef ~]# docker ps
  CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
  712e0516b83b   nginx:latest   "/docker-entrypoint.…"   58 seconds ago   Up 52 seconds   80/tcp    my-nginx
  ```

* leader node 상태 확인
  ```sh
  [root@5ef6c7c6903b ~]# docker service ps my-nginx
  ID             NAME             IMAGE          NODE           DESIRED STATE   CURRENT STATE             ERROR     PORTS
  jxhd4jm3sfxb   my-nginx.1       nginx:latest   5ef6c7c6903b   Running         Running 14 minutes ago
  70jr1a9fektf   my-nginx.2       nginx:latest   778fd17c6129   Running         Running 7 minutes ago
  erlzd41ro3po   my-nginx.3       nginx:latest   0fec15aadeef   Running         Running 23 seconds ago
  boexx44fxgi0    \_ my-nginx.3   nginx:latest   0fec15aadeef   Shutdown        Complete 29 seconds ago
  ```

scale 조정 (scale = 1)
```sh
[root@5ef6c7c6903b ~]# docker service scale my-nginx=1
```

* worker node 1, worker node 2 프로세스 존재하지 않는 것 확인
  ![image](https://github.com/user-attachments/assets/e58b3af4-14f2-439b-b99a-edad3c1714e0)

docker service 삭제
```sh
[root@5ef6c7c6903b ~]# docker service rm my-nginx
```

