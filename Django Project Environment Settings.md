# Django Project 환경설정

## 1. 가상환경 생성 및 활성화

```bash
$ conda create -n mysite python=3.8
$ conda activate mysite
```

<br/>

## 2. 필요 패키지 설치

```bash
$ conda install django
$ pip install mysqlclient

$ conda install pandas
$ conda install -c conda-forge beautifulsoup4
$ conda install matplotlib
$ conda install seaborn
$ conda install plotly
$ conda install -c conda-forge lightgbm
$ conda install -c conda-forge xgboost
$ conda install -c conda-forge scikit-learn
```

<br/>

## 3. Django Project 생성

```bash
$ cd \Projects
$ mkdir mysite # 프로젝트 이름
$ cd \Projects\mysite

$ django-admin startproject config . 	# 프로젝트 디렉토리와 환경설정 디렉토리 구분하여 관리
$ python manage.py runserver 			# 장고 내장서버 구동 확인
```

<br/>

## 4. app 생성

```bash
$ django-admin startapp monitors
```

### 4.1 app url 매핑

```python
# config/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('monitors.urls')),
]
```

```python
# monitors/urls.py
from django.urls import path
from . import views

app_name = 'monitor'

urlpatterns = [
    path('', views.home, name='home'),
    path('view/', views.view, name='view'),
    path('index/', views.Index.as_view(), name='index')
]
```

<br/>

## 5. config 설정

### 5.1 settings.py 분리

```bash
# 개발환경과 운영환경을 분리하여 관리
# base.py / dev.py / prod.py
$ cd config
$ mkdir settings
$ move settings.py settings/base.py
```

### 5.2 환경변수 설정

```python
# base.py (settings.py)
# BASE_DIR Settings
BASE_DIR = Path(__file__).resolve().parent.parent.parent # .parent 추가

# Debug Settings (True: 개발모드 / False: 운영모드)
DEBUG = True

# Allowed Host Settings
ALLOWED_HOSTS = [
    '127.0.0.1',
]

# App Settings
INSTALLED_APPS = [
    ...,
    'monitors',
]

# Templates Directory Settings
TEMPLATES_DIR = os.path.join(BASE_DIR, 'templates')
TEMPLATES = [
	{
		...,
		'DIRS': [TEMPLATES_DIR]
	}
]

# Database Settings
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mysite',
        'USER': 'root',
        'PASSWORD': '202102010',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

# Language, Time Zone Settings
LANGUAGE_CODE = 'ko-kr'
TIME_ZONE = 'Asia/Seoul'
USE_TZ = False
```

### 5.3 Import settings

```bash
# Import settings.py (Django Server)
$ python manage.py runserver --settings=config.settings.dev
$ set DJANGO_SETTINGS_MODULE=config.settings.dev # (python manage.py runserver)
```

<br/>

## 6. Model Settings

```bash
# 외부 데이터베이스 연결
$ python manage.py inspectdb > monitors/models.py # 덮어쓰기 주의

# 프로젝트 생성 후 첫 마이그레이션 생성에서는 app name 생략
$ python manage.py makemigrations

# 해당 app에 대해서만 마이그레이션 생성
$ python manage.py makemigrations monitors

# DB에 마이그레이션 반영 및 버전 이동
$ python manage.py migrate [app_name] [migration_name]
```

