aws 엑세스 키 설정

```sh
aws configure
```

ECR 프라이빗 레파지토리 생성

![image](https://github.com/user-attachments/assets/2e847bff-79ce-4ee6-b6ef-4e6e7521dbf1)

```sh
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 864981757482.dkr.ecr.us-west-1.amazonaws.com
```

```sh
docker build -t cicd-web-project .
```

```sh
docker tag cicd-web-project:latest 864981757482.dkr.ecr.ap-southeast-2.amazonaws.com/cicd-web-project:latest
```

```sh
docker push 864981757482.dkr.ecr.ap-southeast-2.amazonaws.com/cicd-web-project:latest
```

