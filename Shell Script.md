# Shell Script

터미널을 열면 그 터미널이 동작하는 방식을 결정하는 것이 셸 스크립트 언어이다. 셸 스크립트 언어로는 Bash와 Zsh 등이 있다.

<br>

## 1. 변수

셸 스크립트에서 사용되는 변수는 **문자열**로만 취급된다.

`운영체제 변수` : 프로그램이 돌아가는 운영체제의 변수(=환경변수)

`셸 변수` : 터미널 내에서의 변수

`echo` : 변수를 출력하는 명령어

`unset` : 변수를 삭제하는 명령어

`env` : 환경변수를 출력하는 명령어

<br>

## 2. 명령어

### 2.1 export

`export` 명령어로 셸 변수를 환경변수로 저장할 수 있다.

터미널에 `export` 명령어를 입력하고 `env` 명령어를 입력하면 환경변수 목록에 셸 변수가 추가됐음을 볼 수 있다.

하지만 이 환경변수는 **터미널이 종료되면 사라지게** 된다.

매번 셸을 실행할 때마다 셸 변수를 환경변수로 자동으로 설정하고 싶다면 `.bashrc` 파일에 변수를 직접 입력하여 환경변수로 저장할 수 있다.

```bash
vi ~/.bashrc 	# bash
vi ~/.zshrc 	# zsh

export water="삼다수"
export TEMP_DIR=/tmp
export BASE_DIR=$TEMP_DIR/backup
```

<br>

### 2.2 source & bash

`source`(`.`)와 `bash`는 **셸 스크립트 파일을 실행하는 명령어**이다. (`.` 명령어는 bash에서는 사용가능 하지만 zsh에서는 사용할 수 없다)

```bash
# test.sh (셸 스크립트 파일)
echo Hello World!
```

```bash
source test.sh
>>> Hello World!

. test.sh
>>> Hello World!

bash test.sh
>>> Hello World!
```

<br>

#### 2.2.1 변수 유효성

`source`는 **현재 셸**에서 스크립트 파일을 실행하고, `bash`는 **새로운 셸**을 만들어 스크립트 파일을 실행한다.

**셸에서 선언된 변수나 현재 작업 디렉토리의 위치는 해당 셸에서만 유효하며, 셸이 종료되면 모두 사라진다.**

<br>

여기서 `source`는 스크립트 안에서 선언한 변수를 **스크립트 바깥에서 접근**할 수 있다.

`bash`는 스크립트 안에서 선언한 변수는 **스크립트 바깥에서 접근할 수 없으며 스크립트가 끝나면 그대로 소멸**한다.

스크립트 바깥에서의 접근을 원한다면 `export` 명령어를 사용해야한다.

```bash
# test2.sh
TEST_VALUE=123
echo $TEST_VALUE
```

```bash
bash test2.sh
>>> 123
echo $TEST_VALUE
>>>

source test2.sh
>>> 123
echo $TEST_VALUE
>>> 123
```

<br>

#### 2.2.2 cd 경로 유지

`source`는 스크립트 안에서 `cd`를 실행한 결과가 바깥에서도 그대로 유지된다.

`bash`는 스크립트 안에서는 `cd` 경로가 유지되지만, 스크립트 바깥에서는 유지되지 않는다.

```bash
# test3.sh
echo "In file 1: $(pwd)"
cd ..
echo "In file 2: $(pwd)"
```

```bash
# bash
pwd
>>> /Users/choi

bash test3.sh
>>> In file 1: /Users/choi
>>> In file 2: /Users

pwd
>>> /Users/choi


# source
source test3.sh
>>> In file 1: /Users/choi
>>> In file 2: /Users

pwd
>>> /Users
```

<br>

| 명령어 | 역할                         | 사용 셸   | 변수 유효성             | cd 경로 유지            |
| ------ | ---------------------------- | --------- | ----------------------- | ----------------------- |
| source | 셸 스크립트 파일 실행 명령어 | 현재 셸   | 파일 바깥에서 접근 가능 | 파일 바깥에서도 유지됨  |
| bash   | 셸 스크립트 파일 실행 명령어 | 새로운 셸 | 파일 바깥에서 접근 불가 | 파일 바깥에서 유지 안됨 |

<br>

## References

1. [[Linux, Unix] export, echo 명령어](http://keepcalmswag.blogspot.com/2018/06/linux-unix-export-echo_49.html)
2. [source 명령어](https://www.bangseongbeom.com/source-dot.html)