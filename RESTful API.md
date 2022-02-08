# RESTful API의 개념

#### 작성자: 최현호 연구원

> #### 목차
>
> 1. 용어 정의
> 2. REST 특징
> 3. RESTful API 사용의 장점과 단점
> 4. RESTful API 디자인 가이드

<br/>

## 1. 용어 정의

### 1.1 REST

> **RE**presentational **S**tate **T**ransfer

- Wiki: 월드와이드웹(WWW)과 같은 분산 하이퍼미디어 시스템을 위한 소프트웨어 아키텍처의 한 형식. **REST**는 네트워크 아키텍처 원리의 모음으로 여기서 '네트워크 아키텍처 원리'란 자원을 정의하고 자원에 대한 주소를 지정하는 방법 전반을 말한다. (HTTP: 서버와 클라이언트 사이에서 문서를 전송하기 위한 통신규약)

- REST는 네트워크 상에서 Client와 Server 사이의 통신 방식 중 하나

- 자원(Resource)을 표현(Representation)으로 구분하여 해당 자원의 상태(State)를 주고 받는 모든 것 (데이터가 요청되어지는 시점에서 자원의 상태를 전달한다)

- **웹에 존재하는 모든 Resource 자원(문서, 이미지, 동영상, 데이터 등)에 고유한 URI 주소를 부여하고, HTTP Method(POST, GET, PUT, DELETE)를 통해 해당 자원에 대한 CRUD Operation을 적용하는 것**을 의미

  | HTTP Method | 역할                                                     |
  | ----------- | -------------------------------------------------------- |
  | GET         | GET을 통해 해당 **리소스를 조회**합니다.                 |
  | POST        | POST를 통해 해당 URI를 요청하면 **리소스를 생성**합니다. |
  | PUT         | PUT을 통해 해당 **리소스를 수정**합니다.                 |
  | DELETE      | DELETE를 통해 **리소스를 삭제**합니다.                   |

<br/>

### 1.2 API

> **A**pplication **P**rogramming **I**nterface

- Wiki: 응용 프로그램에서 사용할 수 있도록, 운영체제나 프로그래밍 언어가 제공하는 기능을 제어할 수 있게 만든 인터페이스.
- **API는 프로그램 코드를 사용해서 다른 프로그램과 상호작용을 하는 것.**
- **RESTful API**: REST 방식을 따르는 API 서비스를 RESTful API라고 한다.

<br/>

<br/>


## 2. REST 특징

### 2.1 Stateless (무상태성)

- HTTP 프로토콜은 Stateless 프로토콜이므로 REST 역시 Stateless (무상태성)을 갖는다.

- Client의 context를 Server에 저장하지 않는다. (context 정보: 세션이나 쿠키같은 정보)
- Server는 각각의 요청을 완전히 별개의 것으로 처리한다. 즉, 이전 요청과 다음 요청의 처리는 분리되어있고 연결되어있지 않다.

<br/>

### 2.2 Server-Client 구조

- 자원이 있는 Server / 자원을 요청하는 Client 
  - Server: API를 제공하고 데이터 로직처리
  - Client: 사용자 인증이나 context 등을 직접 관리

- Server와 Client의 각각의 역할이 확실히 구분되기 때문에 Server와 Client에서 개발해야할 내용이 명확해지고 서로간 의존성이 줄어든다.

<br/>

### 2.3 Cacheable (캐시 처리기능)

- 웹 표준 HTTP 프로토콜을 그대로 사용하므로 웹에서 사용하는 기존 인프라를 그대로 활용할 수 있다. (HTTP가 가진 특징 중 하나인 캐싱 기능을 사용할 수 있다)
- 대량의 요청을 효율적으로 처리하기 위해 캐시를 사용한다. (캐시 사용으로 응답시간이 빨라지고 REST Server 트랜잭션이 발생하지 않기 때문에 전체 응답시간, 성능, 서버의 자원 이용률 향상에 도움이 된다.)

<br/>

### 2.4 Layered System (계층화)

- Client는 REST API Server만 호출한다.
- REST Server는 다중 계층으로 구성될 수 있다.

<br/>

### 2.5 Uniform Interface (인터페이스 일관성)

- 자원(Resource)에 부여한 URI로 자원에 대한 조작을 일관성있는 인터페이스로 수행한다.

<br/>

<br/>


## 3. RESTful API 사용의 장점과 단점

### 3.1 장점

- HTTP 프로토콜 인프라를 그대로 사용하므로 REST API 사용을 위한 별도의 인프라를 구축할 필요가 없다.
- HTTP 표준 프로토콜을 따르는 모든 플랫폼에서 사용이 가능하다. (특정 언어나 기술에 종속되지 않는다)
- 클라이언트와 서버의 역할을 명확하게 분리한다.
  - 클라이언트는 REST API를 통해 서버와 정보를 주고 받는다. REST의 특징인 Stateless에 따라 서버는 클라이언트 정보가 저장되지 않으며 API 서버는 들어오는 요청만을 처리하면 된다.
- 사내 시스템들도 REST 기반으로 시스템을 분산하여 확장성과 재사용성을 높이고 유지보수와 운용을 편리하게 할 수 있다.

<br/>

### 3.2 단점

- REST는 설계가이드일 뿐이지 명확한 표준이 존재하지 않는다.
- HTTP Method(GET,PUSH,PUT,DELETE 등) 형태가 제한적이다. (사용할 수 있는 메소드 개수 역시 제한적이다)

<br/>

<br/>

## 4. RESTful API 디자인 가이드

- 자원에 대한 행위는 HTTP Method(GET,POST,PUT,DELETE)로 표현한다.

- URI는 자원을 표현하는데 중점을 두어야한다. (행위에 대한 표현이 포함되는 것 지양)

  ```http
  GET /members/delete/1 (x)
  ```

  ```http
  DELETE /members/1 (o)
  ```


<br/>

<br/>

## References

- https://ko.wikipedia.org/wiki/REST
- https://ko.wikipedia.org/wiki/API

- https://gmlwjd9405.github.io/2018/09/21/rest-and-restful.html
- https://engkimbs.tistory.com/626

- https://www.redhat.com/ko/topics/api/what-is-a-rest-api
- https://meetup.toast.com/posts/92
