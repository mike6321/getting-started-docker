docker service 실행

```sh
docker service create --name myweb3 --replicas 4 --rollback-delay 10s --rollback-parallelism 1 --rollback-failure-action pause nginx:latest
```

* 확인
  ```sh
  [root@8db084e9c882 ~]# docker service ps myweb3
  ID             NAME       IMAGE          NODE           DESIRED STATE   CURRENT STATE            ERROR     PORTS
  k401zhyght41   myweb3.1   nginx:latest   8db084e9c882   Running         Running 14 seconds ago             
  el2tffr2efh8   myweb3.2   nginx:latest   1b57e615d31c   Running         Running 14 seconds ago             
  sq9d76cjgl8a   myweb3.3   nginx:latest   62c18e7508af   Running         Running 14 seconds ago             
  ajt80aj83zji   myweb3.4   nginx:latest   8db084e9c882   Running         Running 14 seconds ago    
  ```

이미지 변경1
```sh
docker service update --image nginx:1.24 myweb3
```

```sh
[root@8db084e9c882 ~]# docker service ps myweb3
ID             NAME           IMAGE          NODE           DESIRED STATE   CURRENT STATE             ERROR     PORTS
iu5155wm1o9g   myweb3.1       nginx:1.24     1b57e615d31c   Running         Running 19 seconds ago              
iu64huw9swv4    \_ myweb3.1   nginx:latest   1b57e615d31c   Shutdown        Shutdown 20 seconds ago             
kj1dyy9clq20   myweb3.2       nginx:1.24     8db084e9c882   Running         Running 16 seconds ago              
x4vlzt1ydl2o    \_ myweb3.2   nginx:latest   8db084e9c882   Shutdown        Shutdown 17 seconds ago             
6307ryq7i7vz   myweb3.3       nginx:1.24     8db084e9c882   Running         Running 18 seconds ago              
vd1quq5s8fc1    \_ myweb3.3   nginx:latest   62c18e7508af   Shutdown        Shutdown 18 seconds ago             
dwsmfvldrgv8   myweb3.4       nginx:1.24     62c18e7508af   Running         Running 21 seconds ago              
7wda65b82okn    \_ myweb3.4   nginx:latest   62c18e7508af   Shutdown        Shutdown 21 seconds ago    
```

이미지 변경2

```sh
docker service update --image nginx:1.25 myweb3
```

```sh
[root@8db084e9c882 ~]# docker service ps myweb3
ID             NAME           IMAGE          NODE           DESIRED STATE   CURRENT STATE                 ERROR     PORTS
9kse65qyepky   myweb3.1       nginx:1.25     8db084e9c882   Running         Running 13 seconds ago                  
iu5155wm1o9g    \_ myweb3.1   nginx:1.24     1b57e615d31c   Shutdown        Shutdown 17 seconds ago                 
iu64huw9swv4    \_ myweb3.1   nginx:latest   1b57e615d31c   Shutdown        Shutdown about a minute ago             
jivzifr8mneu   myweb3.2       nginx:1.25     8db084e9c882   Running         Running 11 seconds ago                  
kj1dyy9clq20    \_ myweb3.2   nginx:1.24     8db084e9c882   Shutdown        Shutdown 11 seconds ago                 
x4vlzt1ydl2o    \_ myweb3.2   nginx:latest   8db084e9c882   Shutdown        Shutdown about a minute ago             
qh8z38ujdfa4   myweb3.3       nginx:1.25     1b57e615d31c   Running         Running 25 seconds ago                  
6307ryq7i7vz    \_ myweb3.3   nginx:1.24     8db084e9c882   Shutdown        Shutdown 29 seconds ago                 
vd1quq5s8fc1    \_ myweb3.3   nginx:latest   62c18e7508af   Shutdown        Shutdown about a minute ago             
ya8ahpiut52w   myweb3.4       nginx:1.25     62c18e7508af   Running         Running 18 seconds ago                  
dwsmfvldrgv8    \_ myweb3.4   nginx:1.24     62c18e7508af   Shutdown        Shutdown 23 seconds ago                 
7wda65b82okn    \_ myweb3.4   nginx:latest   62c18e7508af   Shutdown        Shutdown about a minute ago
```

롤백 적용

* 이전 버전 (nginx:1.24) 로 롤백
* 이전 상태로만의 롤백만 가능

```sh
docker service update --rollback myweb3
```

```sh
[root@8db084e9c882 ~]# docker service ps myweb3
ID             NAME           IMAGE          NODE           DESIRED STATE   CURRENT STATE             ERROR     PORTS
8xmfuizuc5lo   myweb3.1       nginx:1.24     1b57e615d31c   Running         Running 21 seconds ago              
9kse65qyepky    \_ myweb3.1   nginx:1.25     8db084e9c882   Shutdown        Shutdown 22 seconds ago             
iu5155wm1o9g    \_ myweb3.1   nginx:1.24     1b57e615d31c   Shutdown        Shutdown 2 minutes ago              
iu64huw9swv4    \_ myweb3.1   nginx:latest   1b57e615d31c   Shutdown        Shutdown 3 minutes ago              
vts8dqulk6ke   myweb3.2       nginx:1.24     8db084e9c882   Running         Running 10 seconds ago              
jivzifr8mneu    \_ myweb3.2   nginx:1.25     8db084e9c882   Shutdown        Shutdown 10 seconds ago             
kj1dyy9clq20    \_ myweb3.2   nginx:1.24     8db084e9c882   Shutdown        Shutdown 2 minutes ago              
x4vlzt1ydl2o    \_ myweb3.2   nginx:latest   8db084e9c882   Shutdown        Shutdown 3 minutes ago              
prnfocplncot   myweb3.3       nginx:1.24     1b57e615d31c   Running         Running 45 seconds ago              
qh8z38ujdfa4    \_ myweb3.3   nginx:1.25     1b57e615d31c   Shutdown        Shutdown 45 seconds ago             
6307ryq7i7vz    \_ myweb3.3   nginx:1.24     8db084e9c882   Shutdown        Shutdown 2 minutes ago              
vd1quq5s8fc1    \_ myweb3.3   nginx:latest   62c18e7508af   Shutdown        Shutdown 3 minutes ago              
u97uzare9h8u   myweb3.4       nginx:1.24     62c18e7508af   Running         Running 33 seconds ago              
ya8ahpiut52w    \_ myweb3.4   nginx:1.25     62c18e7508af   Shutdown        Shutdown 33 seconds ago             
dwsmfvldrgv8    \_ myweb3.4   nginx:1.24     62c18e7508af   Shutdown        Shutdown 2 minutes ago              
7wda65b82okn    \_ myweb3.4   nginx:latest   62c18e7508af   Shutdown        Shutdown 3 minutes ago
```

