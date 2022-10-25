# vi

> vi는 Emacs와 함께 유닉스 환경에서 가장 많이 쓰이는 텍스트 편집기이다.
>
> git bash의 기본 텍스트 편집기는 vi editor이다.

<br/>

## vi config

Windows 환경에서 아래의 명령어를 통해 텍스트 편집기를 vi가 아닌 메모장으로 바꿀수도 있다.

```bash
$ git config --local core.editor notepad
```

<br/>

## vi commit

commit 메시지를 한줄로 간단하게 작성할 경우 `-m` 옵션을 주어서 메시지 편집을 생략할 수 있다.

```bash
$ git commit -m "Initial commit"
```

<br/>

## vi mode

![image](https://user-images.githubusercontent.com/64063767/155349297-d75af2d4-6a2b-4db8-a61d-fc1a0e4819f6.png)

| Command mode                                                 | Edit mode                                                    | Last line mode                                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![image](https://user-images.githubusercontent.com/64063767/155348345-c8b8db61-81c5-4872-bdcc-7e52428180d8.png) | ![image](https://user-images.githubusercontent.com/64063767/155350151-6c94de17-e9ee-44ff-a396-c51a9e5a0d20.png) | ![image](https://user-images.githubusercontent.com/64063767/155350443-38f6b28c-77ab-4bad-a5c8-1a227d1296f1.png) |

- vi는 Command mode / Edit mode / Last line mode 3가지 모드가 있다.

- vi를 처음 열면 위와 같은 Command mode 화면이 나타난다. Command mode에서는 텍스트 입력이 불가하다.

- Command mode에서 `i`, `a`, `o` 키를 눌러 Edit mode로 진입해야 텍스트 입력이 가능하다.
- `Esc` 키를 눌러 edit mode를 나간 뒤에 `:wq`를 입력하여 커밋 내용을 **저장하고 나간다.**

- `w`는 저장, `q`는 편집기 종료를 의미한다. `wq`는 저장과 동시에 편집기를 종료하는 명령어이다.
- `wq`대신 `q!` 명령으로 저장하지 않고 강제로 나가면 커밋이 작성되지 않는다.
- 저장하였어도 커밋 메시지가 없으면 커밋이 작성되지 않는다.
- 커밋 메시지 내의 `#`으로 시작하는 줄은 주석 처리되어, 해당 줄은 커밋 메시지로 저장되지 않는다.

<br/>

## 문자열 찾기

`grep` 명령어를 사용하여 소스 내에서 원하는 문자열을 추출할 수 있다.

```bash
# grep <regex> <file>
$ grep "record\[[0-9]*\]\[name\]" thekie.com
```

<br/>

## vi command

![image](https://user-images.githubusercontent.com/64063767/197719302-7c042811-7548-4c25-ae73-c71380ac58f1.png)

```
# 커서위치부터 끝까지 삭제/복사 (명령 모드에서 수행)
# <mark> <buffer-name> <go-to-line> <operation> <go-to-marker> <buffer-name>
m a :$ d/y ' a
```