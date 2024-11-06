Local Registry Container 사용

```sh
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

repository 목록 조회

```sh
curl http://localhost:5000/v2/_catalog
```

```sh
curl http://localhost:5000/v2/nodejs-demo/tags/list
```

repository push

```sh
docker tag nodejs-demo:v1.0 localhost:5000/nodejs-demo:v1.0
```

```sh
docker push localhost:5000/nodejs-demo:v1.0
```

Cloud Registry Container 사용

```sh
docker tag nodejs-demo:v2.0 junwoo123/nodejs-demo:v2.0
```

```sh
docker push nodejs-demo:v2.0
```

다운로드

```
docker pull junwoo123/nodejs-demo:v2.0
```
