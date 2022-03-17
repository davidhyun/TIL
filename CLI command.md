# CLI Command (MacOS)

> CLI: **C**ommand **L**ine **I**nterface
>
> GUI: **G**raphic **U**ser **I**nterface



## Basic CLI Command

| Command                                    | Description                                         |
| ------------------------------------------ | --------------------------------------------------- |
| `pwd`                                      | 현재 작업중인 디렉토리 출력                         |
| `ls`                                       | 디렉토리 목록 출력                                  |
| `mkdir [dir]`                              | 디렉토리 생성                                       |
| `touch [file]`                             | 빈 파일 생성                                        |
| `chmod [option] [mode] [file]`             | 파일의 모드를 변경                                  |
| `cp -option [src file/dir] [dst file/dir]` | 파일 또는 디렉토리 복사                             |
| `mv [src file/dir] [dst file/dir]`         | 파일 또는 디렉토리 이동 (경로가 같을 경우 이름변경) |
| `rm -option [file/dir]`                    | 파일 또는 디렉토리 제거                             |
| `vi [file]`                                | vi 텍스트 편집기 실행                               |
| `cat [file]`                               | 파일내용 출력                                       |
| `echo [str]`<br />`echo [str] > [file]`    | 터미널에 문자열 출력<br />문자열이 입력된 파일 생성 |



## System Config Command

| Command             | Description                          |
| ------------------- | ------------------------------------ |
| `top`               | 시스템 CPU 점유율 확인               |
| `ps`                | 현재 동작중인 프로세스 확인          |
| `kill -15/-9 [PID]` | 특정 프로세스 정상/강제 종료         |
| `ctrl` + `c`        | 프로세스 종료 (프로세스 재개 불가능) |
| `ctrl` + `z`        | 프로세스 정지 (프로세스 재개 가능)   |
| `exit`              | 쉘을 빠져나오거나 스크립트를 종료    |
| `ctrl` + `l`        | 화면 clear                           |



## Network Config Command

| command                          | Description                                                  |
| -------------------------------- | :----------------------------------------------------------- |
| `ifconfig`                       | 네트워크 설정 정보 확인                                      |
| `route -n get default`           | 기본게이트웨이 주소 확인                                     |
| `nslookup server`                | 등록된 DNS 서버주소 확인                                     |
| `nslookup [dns/ip] [dns server]` | DNS 서버에 도메인네임이 가지는 IP(또는 IP에 부여된 도메인네임)를 질의하는 명령어 |
| `ping [dst dns/ip]`              | 네트워크 상태를 진단하는 명령어. ICMP 프로토콜을 이용하여 데이터 패킷을 목적지 서버로 보낸 후 대상 컴퓨터가 응답을 하는지 확인 |
| `traceroute [dst dns/ip]`        | ICMP 프로토콜을 이용하여 데이터 패킷을 목적지 서버로 보내어 가는 네트워크 경로를 확인 (거쳐가는 라우터 IP들을 출력) |