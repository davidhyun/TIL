# Docker

>도커는 어플리케이션을 신속하게 구축, 테스트 및 배포할 수 있는 소프트웨어 플랫폼이다.
>
>도커로 컨테이너 환경에서 독립적으로 어플리케이션을 실행할 수 있다.

### 컨테이너

컨테이너는 격리된 공간에서 프로세스가 동작하는 기술이다. 프로세스를 격리한다는 점에서 기존의 OS 가상화(Virtual Machine)와 차이가 있다.

| VM                                                           | Docker                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![VM](https://user-images.githubusercontent.com/64063767/177025243-7bafad20-2911-49c7-a147-482ea5e68eef.png) | ![Docker](https://user-images.githubusercontent.com/64063767/177025232-2a650065-490a-4014-9005-66cb01374019.png) |

<br/>

## 1. 이미지 생성

### 1.1 Dockerfile 작성

```dockerfile
# python:3.9 이미지로부터
FROM python:3.9

# 컨테이너 내부 작업 디렉토리 (해당 디렉토리 없으면 생성)
# 이후 명령어는 아래 지정한 WORKDIR를 기준으로 실행
WORKDIR /usr/src/app

# 컨테이너 타임존 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 파이썬 환경변수 설정
ENV PYTHONPATH="$PYTHONPATH:/usr/src/app"

# 패키지관리자 업데이트
RUN apt-get update
RUN apt-get install -y vim apt-utils
RUN pip install --upgrade pip

# 이미지에 호스트의 파일이나 디렉토리를 복사
# COPY <host 파일경로(SRC)> <컨테이너 파일경로(DST)>
# COPY 이전 명령은 캐시를 사용하여 빠르게 이미지 빌드 (COPY 명령어 위치 중요)
COPY . .

# 의존성 패키지 설치
RUN pip install -r requirements.txt

# 컨테이너가 뜰 때 실행되는 명령어 지정 (데몬 실행)
CMD ["python","app.py"] # 셸에서 도커로 컨테이너를 띄울 때 --entrypoint 옵션을 주면 Dockerfile 내에서 지정한 CMD 명령은 무시됨
ENTRYPOINT ["python","app.py"]
```

### 1.2 이미지 빌드

```bash
$ docker build -t <image-name> . 												# default로 현재 디렉토리에 있는 Dockerfile을 찾아서 이미지 생성
$ docker build -f <Dockerfile-path> -t <image-name> . 	# Dockerfile 지정
```

<br/>

## 2. 컨테이너 실행

```bash
# 컨테이너 실행
$ docker run -d -it --name <container-name> <image-name>

# 컨테이너 로그 확인
$ docker logs <container-name>

# 실행중인 컨테이너의 shell에 접속 (탈출: exit)
$ docker exec -it <container-name> /bin/bash
```

### 2.1 볼륨 마운트

도커로 생성한 볼륨을 컨테이너 내부의 작업 디렉토리와 마운트하는 것을 볼륨 마운트라 한다.

- 장점 : 도커로 관리됨. 컨테이너 중단/제거시에도 볼륨은 제거되지 않는다.

- 단점 : 컨테이너와 마운트 되어있지 않으면 볼륨 내부의 소스를 들여다보기 불편하다.

```bash
$ docker volume create <volume-name> # 볼륨 생성
$ docker run -d -it --name <container-name> -v <volume-name>:<container-workdir> <image-name>
```

### 2.2 바인드 마운트

Host 디렉토리와 컨테이너 내부의 작업 디렉토리를 직접 마운트하는 것을 바인드 마운트라 한다.

- 장점 : Host에서 직접 내부 소스를 들여다보기 편하다.

- 단점 : 디렉토리 경로 변경시 다시 마운트 필요하다.

```bash
$ docker run -d -it --name <container-name> -v <host-workdir>:<container-workdir> <image-name>
```

<br/>

## 3. Docker compose

> Docker compose는 여러 개의 컨테이너로부터 이루어진 서비스를 구축, 실행하는 순서를 지정하여 서비스를 제공한다.
>
> docker-compose 명령어를 통해 compose 파일로 사전에 정의한 컨테이너들을 일괄적으로 띄울 수 있다.

### docker-compose 설치

Windows나 macOS에서 사용하는 도커 데스크톱은 도커 컴포즈가 함께 설치되지만 리눅스에서는 도커 컴포즈와 파이썬3 런타임 및 필요도구(python3, python3-pip 패키지)를 설치해야 한다. (도커 컴포즈는 파이썬으로 작성된 프로그램)

```bash
# 리눅스 서버에서 한번만 수행해서 docker 명령어처럼 사용
$ sudo apt install -y python3 python3-pip
$ sudo pip3 install docker-compose
```

<br/>

## 4. 도커 컨테이너 소스 원격 디버깅 (VSCode)

![image](https://user-images.githubusercontent.com/64063767/171557093-ba54b189-f718-4d84-9f00-7e3d03d8a720.png)

### 4.1 볼륨/바인드 마운트

원격서버에서 컨테이너와 볼륨 또는 바인드 마운트가 되어있어야 한다.

```bash
# 볼륨 마운트
$ docker run -d -it --name <container-name> -v <volume-name>:<container-workdir> <image-name>

# 바인드 마운트 (추천)
$ docker run -d -it --name <container-name> -v <host-workdir>:<container-workdir> <image-name>
```

### 4.2 로컬 IDE 환경설정

1. 로컬 VSCode의 settings.json에 아래 한줄 추가

```bash
# settings.json
"docker.host": "tcp://localhost:23750"
```

1. 로컬 VSCode의 확장기능으로 `Remote-Containers`  설치
2. SSH 터널링 이후, 로컬 VSCode에서 `python extension pack`을 **원격 도커 컨테이너에 설치**
3. (옵션) 로컬 VSCode에서 `launch.json` 설정을 변경하여 디버깅 가능

### 4.3 SSH 터널링

```bash
$ ssh -NL localhost:23750:/var/run/docker.sock kbet@192.168.10.18 # 비밀번호 입력 후 대기
```

### 4.4 디버깅

- VSCode Palette에서 Remote-Containers:Attach to Running Container로 디버깅할 컨테이너를 선택한 후 소스 실행 및 디버깅을 할 수 있다.

- 소스를 수정하며 디버깅할 수 있지만 변경된 소스를 반영하려면 컨테이너를 다시 띄워야 한다.

<br/>

## References

- [기술도서] 그림과 실습으로 배우는 도커&쿠버네티스

- [Remote Docker Container Debugging with VSCode](https://www.youtube.com/watch?v=w77D5KuJ7eE&t=372s)