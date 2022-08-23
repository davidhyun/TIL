# 문자열 찾기

`grep` 명령어를 사용하여 소스 내에서 원하는 문자열을 추출할 수 있다.

```bash
# grep <regex> <file>
$ grep "record\[[0-9]*\]\[name\]" thekie.com
```

<br/>

# vi 편집

### 행 삭제

```bash
# command mode
# <mark> <buffer-name> <go-to-endline> <operation> <go-to-marker> <buffer-name>
m a :$ d ' a
```
