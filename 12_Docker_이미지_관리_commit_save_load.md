현재 작업중인 컨테이너 이미지화 (COMMIT)

```sh
docker commit 8db084e9c882 edowon0623/docker-server:manager
```

* 확인

  * 용량이 0.73GB 늘어난 것 확인

  ```sh
  docker images | grep docker-server
  edowon0623/docker-server    manager   d5428ac85cf7   55 seconds ago   1.97GB
  edowon0623/docker-server    m1        7a5b41421a7c   2 years ago      1.24GB
  ```

이미지 export (SAVE)

```sh
docker save -o docker-server-manager.jar edowon0623/docker-server:manager
```

* 확인
  ```sh
  ls -l
  total 3908568
  -rw-r--r--@ 1 cg6jq7y05g  staff        1373 Nov 17 19:43 docker-compose-macos-apple.yml
  -rw-r--r--@ 1 cg6jq7y05g  staff        1469 Nov 17 17:29 docker-compose-windows10.yml
  -rw-r--r--@ 1 cg6jq7y05g  staff        1484 Nov 17 17:29 docker-compose-windows11.yml
  -rw-------@ 1 cg6jq7y05g  staff  2001085952 Nov 18 23:20 docker-server-manager.jar
  drwxr-xr-x@ 5 cg6jq7y05g  staff         160 Nov 17 20:01 stack
  ```

tar 파일 이미지화 (LOAD)

```sh
docker load -i ./docker-server-manager.jar 
70f038840d85: Loading layer  743.4MB/743.4MB
Loaded image: edowon0623/docker-server:manager
```

