Swarm에서 사용할 포트

* TCP port 2377 : cluster management 통신에 사용
* TCP/UDP port 7946 : node 간의 통신에 사용
* TCP/UDP port 4789 : overlay network 트래픽에 사용

https://hub.docker.com/r/edowon0623/docker-server

------

manager node 기동

```sh
docker run --privileged --name manager -itd -p 10022:22 -p 8081:8080 -e container=docker -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host edowon0623/docker-server:m1 /usr/sbin/init
```

* docker 접속
  ```sh
  docker exec -it manager bash
  ```

* ssh 접속
  ```sh
  ssh root@127.0.0.1 -p 10022
  ```

  password: P@ssw0rd
  ssh 접속 이력 확인

  ```sh
  cd ~/.ssh
  code known_hosts
  ```

* docker 설치여부 확인 (기동되지 않은 상태)
  ```sh
  docker version
  
  Client: Docker Engine - Community
   Version:           20.10.17
   API version:       1.41
   Go version:        go1.17.11
   Git commit:        100c701
   Built:             Mon Jun  6 23:02:26 2022
   OS/Arch:           linux/arm64
   Context:           default
   Experimental:      true
  
  Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
  ```

  * 기동
    ```sh
    systemctl start docker
    ```

* docker swarm 초기화

  ```sh
  docker swarm init
  ```

workder node 기동

```sh
docker run --privileged --name worker01 -itd -p 20022:22 -p 8082:8080 -e container=docker -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host edowon0623/docker-server:m1 /usr/sbin/init
```

```sh
docker run --privileged --name worker02 -itd -p 30022:22 -p 8083:8080 -e container=docker -v /sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host edowon0623/docker-server:m1 /usr/sbin/init
```

worker node 접속

```sh
ssh root@127.0.0.1 -p 20022
```

```sh
ssh root@127.0.0.1 -p 30022
```

<img width="2556" alt="image" src="https://github.com/user-attachments/assets/bfe82f9d-1f14-4f2d-9de7-703e624adc7a">

* worker node docker 활성화
  ```sh
  systemctl start docker
  ```

manager node에서 token 확인

```sh
docker swarm join-token worker

docker swarm join --token SWMTKN-1-5pxnwwcbgmdlm5ckfgj2cv0l01x0urhbr3sacp0641rfh22j8z-6mmxm51epe4ksyf90wulyl6rg 172.17.0.4:2377
```

worker node docker swarm 참여

* worker1

```sh
[root@778fd17c6129 ~]# docker swarm join --token SWMTKN-1-5pxnwwcbgmdlm5ckfgj2cv0l01x0urhb
r3sacp0641rfh22j8z-6mmxm51epe4ksyf90wulyl6rg 172.17.0.4:2377
This node joined a swarm as a worker.
```

* worker2

```sh
[root@0fec15aadeef ~]# docker swarm join --token SWMTKN-1-5pxnwwcbgmdlm5ckfgj2cv0l01x0urhb
r3sacp0641rfh22j8z-6mmxm51epe4ksyf90wulyl6rg 172.17.0.4:2377
This node joined a swarm as a worker.
```

manager node 에서 docker swarm 에 참여중인 노드 확인

```sh
[root@5ef6c7c6903b ~]# docker node ls
ID                            HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
0gxb2xwznfurcyaa2tprkub4s     0fec15aadeef   Ready     Active                          20.10.17
wcggf1rxr1a0k1kgrvtj9prx8 *   5ef6c7c6903b   Ready     Active         Leader           20.10.17
waisqp96n8fv1ybp23rvmeayb     778fd17c6129   Ready     Active                          20.10.17
```

