### 컨테이너간 네트워크 연결

* 우분투 실행

```sh
docker run -it ubuntu:16.04 bash
```

```sh
hostname -i
```

* 네트워크 생성

```sh
docker network create --driver bridge my-network
```

```sh
NETWORK ID     NAME         DRIVER    SCOPE
33235d5ff5e9   bridge       bridge    local
ee333830bae0   host         host      local
b3ac71c5adc5   my-network   bridge    local
2ab5eaa81d68   none         null      local
```

* 생성한 네트워크 정보 확인

```sh
docker network inspect my-network
```

```json
[
    {
        "Name": "my-network",
        "Id": "b3ac71c5adc58ee5cdc814978f360fa8256ff5456c1beb1f103f60e80d3696ec",
        "Created": "2024-10-31T12:36:40.731470216Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
```

-> 포함된 컨테이너 x

* Network 연결

```sh
docker run -d -p 5000:5000 --restart always --network my-network --name registry registry:2
```

* 확인

```sh
docker network inspect my-network
```

```json
[
    {
        "Name": "my-network",
        "Id": "b3ac71c5adc58ee5cdc814978f360fa8256ff5456c1beb1f103f60e80d3696ec",
        "Created": "2024-10-31T12:36:40.731470216Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "50fc8770afde7333b3173223141a9f488668c08c28496a1519cd1d03d61c0367": {
                "Name": "registry",
                "EndpointID": "7384ba18d097455c730a797c10261ad14bd757ed2cc46ce2e4c9b7d5708780b2",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```

* 현재 ubuntu 는 bridge(172.17.0.5) 에 포함되어있고 registry는 my-network(172.18.02) 에 포함되어있다.
* 다른 대역이기 때문에 서로 통신할 수 없다. 

* Ping으로 확인

```sh
apt update
```

```sh
apt install iputils-ping
```

```sh
ping 172.18.0.2

root@8fed611195a7:/# ping 172.18.0.2
PING 172.18.0.2 (172.18.0.2) 56(84) bytes of data.
--- 172.18.0.2 ping statistics ---
33 packets transmitted, 0 received, 100% packet loss, time 32798ms
```

* ubuntu를 같은 my-network에 포함시키고 ping 테스트

```sh
docker run -it --network my-network ubuntu:16.04 bash
```

```sh
root@95fd826e96fe:/# ping 172.18.0.2
PING 172.18.0.2 (172.18.0.2) 56(84) bytes of data.
64 bytes from 172.18.0.2: icmp_seq=1 ttl=64 time=0.282 ms
64 bytes from 172.18.0.2: icmp_seq=2 ttl=64 time=0.184 ms
64 bytes from 172.18.0.2: icmp_seq=3 ttl=64 time=0.184 ms
64 bytes from 172.18.0.2: icmp_seq=4 ttl=64 time=0.218 ms
^C
--- 172.18.0.2 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3114ms
rtt min/avg/max/mdev = 0.184/0.217/0.282/0.040 ms
```

-> 성공

* 이미 만들어진 Container 에 Network를 추가하는 방법
* nodejs-demo:v1.0 컨테이너 실행 (daemon)

```sh
docker run -d -p 18000:18000 --name my-node nodejs-demo:v1.0
```

* 상세정보 확인

```sh
docker container inspect my-node
```

```sh
"bridge": {
    "IPAMConfig": null,
    "Links": null,
    "Aliases": null,
    "MacAddress": "02:42:ac:11:00:04",
    "NetworkID": "33235d5ff5e98ac0a66c1e26d969129637fafa98cf12195e6e11d8296a0767d9",
    "EndpointID": "9206403165ba3184c7cc7de42b18dfc33fa1ea0f6158ea8f2f28573ddd22f9c6",
    "Gateway": "172.17.0.1",
    "IPAddress": "172.17.0.4",
    "IPPrefixLen": 16,
    "IPv6Gateway": "",
    "GlobalIPv6Address": "",
    "GlobalIPv6PrefixLen": 0,
    "DriverOpts": null,
    "DNSNames": null
}
```

* my-network 연결

```sh
docker network connect my-network my-node
```

* 연결 확인

```sh
docker container inspect my-node
```

```sh
"Networks": {
    "bridge": {
        "IPAMConfig": null,
        "Links": null,
        "Aliases": null,
        "MacAddress": "02:42:ac:11:00:04",
        "NetworkID": "33235d5ff5e98ac0a66c1e26d969129637fafa98cf12195e6e11d8296a0767d9",
        "EndpointID": "9206403165ba3184c7cc7de42b18dfc33fa1ea0f6158ea8f2f28573ddd22f9c6",
        "Gateway": "172.17.0.1",
        "IPAddress": "172.17.0.4",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "DriverOpts": null,
        "DNSNames": null
    },
    "my-network": {
        "IPAMConfig": {},
        "Links": null,
        "Aliases": [],
        "MacAddress": "02:42:ac:12:00:04",
        "NetworkID": "b3ac71c5adc58ee5cdc814978f360fa8256ff5456c1beb1f103f60e80d3696ec",
        "EndpointID": "6f01c4af888cd89d14381a0a8800d061bc7af3669c8749b669b8e651cc92c12f",
        "Gateway": "172.18.0.1",
        "IPAddress": "172.18.0.4",
        "IPPrefixLen": 16,
        "IPv6Gateway": "",
        "GlobalIPv6Address": "",
        "GlobalIPv6PrefixLen": 0,
        "DriverOpts": {},
        "DNSNames": [
            "my-node",
            "8b8151ef7aa8"
        ]
    }
}
```
