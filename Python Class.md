# Class

> 클래스는 하나의 틀로써 이 틀로 객체(인스턴스) 결과물을 원하는대로 찍어낼 수 있다.

- ``__init__(self)``
  - 클래스를 선언하는 순간 실행되는 함수(**생성자**)
  - 객체(인스턴스)를 만들 때 자동으로 호출되는 특별한 **초기화 메서드**
- `self`
  - 클래스를 저장할 변수
- `super()`
  - 부모 클래스를 상속받아 부모 클래스의 메서드를 모두 가져온다.

```python
# Starcraft Class
class Unit:
    def __init__(self, tribe, name, hp, damage):
        self.tribe = tribe
        self.name = name
        self.hp = hp
        self.damage = damage
        print("{0}의 {1} 유닛이 생성되었습니다.".format(self.tribe, self.name))
        
    def info(self):
        print("체력 {0}, 공격력 {1}".format(self.hp, self.damage))
```

```python
# 클래스 상속
class Command(Unit):
    def __init__(self, tribe, name, hp, damage):
        super().__init__(tribe, name, hp, damage)
        self.response = ["같은 종족끼리는 공격 불가합니다.", "공격을 속행하겠습니다."]
        
    def attack(self, obj):
        if obj.tribe == self.tribe:
            print(self.response[0])
        else:
            print(self.response[1])
```

```python
marine = Unit("테란", "마린", 40, 6)
>>> "테란의 마린 유닛이 생성되었습니다."
marine.info()
>>> "체력 40, 공격력 6"

marine2 = Command("테란", "마린", 40, 6)
>>> "테란의 마린 유닛이 생성되었습니다."
marine2.attack(marine)
>>> "같은 종족끼리는 공격 불가합니다."

zeolot = Command("프로토스", "질럿", 160, 16)
>>> "프로토스의 질럿 유닛이 생성되었습니다."
zeolot.attack(marine)
>>> "공격을 속행하겠습니다."
```

