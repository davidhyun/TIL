# SSH

> SSH(Secure Shell)는 원격 Host 접속위한 보안 프로토콜.
>
> ssh 원격 터미널 접속 외에도 ssh tunneling(ssh port forwarding) 기능을 제공.

<br/>

# SSH Tunneling

- **외부에서 직접 접근이 불가한 서비스에 접속하기 위해 SSH 연결을 통해 포탈을 열어주는 기술**
- SSH Tunneling은 연결 수립을 누가 하느냐, 그 **연결 수립 주체에 따라 Local과 Remote로 나뉜다.** (Dynamic 터널링 방식은 여기서 다루지 않음)
- SSH Tunneling 언제 사용할까?
  - 외부에서 원격 호스트에 SSH 접속은 가능한데 원격 호스트의 로컬 서비스(ex. 127.0.0.1:80)를 이용하고 싶다 > **Local Tunneling**
  - 외부에서 원격 호스트에 접속하고 싶은데 방화벽으로 막혀있다 > **Remote Tunneling**
  
- 주의할 점 : TCP Only. 대규모 트래픽 처리에는 적합하지 않다. 어찌됐든 방화벽을 우회하는 방식이기 때문에 네트워크 보안상 권장되는 방식은 아니다. 필요할 때만 제한적인 사용을 권장한다.

<br/>

## Local Tunneling

- **SSH Client가 연결 수립 주체** (SSH Client**에서** SSH Server**로** 연결)

| Network Policy                                               | SSH Tunneling                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://user-images.githubusercontent.com/64063767/197710681-fb850eb1-b19c-4e0c-b973-5c1495528d8e.png) | ![image](https://user-images.githubusercontent.com/64063767/197710822-c615bd77-d28a-4182-8838-0f6e0baa3cf3.png) |

```bash
# At SSH Client (ex. 192.168.1.200)
$ ssh -L <Client Listening Port>:<Destination IP>:<Destination Port> <Server User>@<Server IP> [-p ssh port]
$ ssh -L 8585:127.0.0.1:80 suser@192.168.1.201
```

<br/>

## Remote Tunneling

- **SSH Server가 연결 수립 주체** (SSH Server**에서** SSH Client**로** 연결)

| Network Policy                                               | SSH Tunneling                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://user-images.githubusercontent.com/64063767/197711192-9e830226-5eee-4399-8a73-186d75385c06.png) | ![image](https://user-images.githubusercontent.com/64063767/197711133-89b32c17-0f1f-490c-a237-901d4d413517.png) |

```bash
# At SSH Server (ex. 192.168.1.201)
$ ssh -R <Client Listening Port>:<Destination IP>:<Destination Port> <Client User>@<Client IP> [-p ssh port]
$ ssh -R 8585:127.0.0.1:80 cuser@192.168.1.200

# 외부에서 직접 접근이 불가한 EHP 서비스(192.168.0.200:502)를 이용하기 위해 터널링. At EMS Server (192.168.0.101)
$ ssh -R 123.143.163.20:9502:192.168.0.200:502 kbet@erp.kbet.or.kr -p XXXX
```