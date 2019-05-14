# 6장 돌아온 '모두를 위한 평등'

## 6장 목표

```
Money 클래스를 만들어 공통의 equals() 코드를 갖게하자 
```

### 1. 실행 가능하게 만들기

공통 상위 클래스 생성

```ruby
class Money
end
```

상속으로 변경하기

```ruby
class Dollar < Money .
  ...
end

class Franc < Money 
  ...
end

class Money
  attr_accessor :amount
end
```

임시 변수 선언 부분 변경하기. 

> 책에서는 타입 캐스팅을 해줬는데, 루비에서는 자동으로 해주기 때문에 건너 뛰었고, 임시 변수 이름만 변경하였다. 

```ruby
  # class Dollar
  def equals(object)
    dollar = object.amount()
    amount == dollar
  end
```

더 원활하게 임시 변수의 이름을 변경한다. 

```ruby
  # Dollar
  def equals(object)
    money = object.amount()
    amount == money
  end
```

이렇게 하면 메서드를 Money 클래스로 옮길 수 있다. Franc 에 `equals()` 를 제거하고, Franc 에 대한 동치성 테스트를 넣자. 

```ruby
  def test_equality()
    assert_true(Dollar.new(5).equals(Dollar.new(5)))
    assert_false(Dollar.new(5).equals(Dollar.new(8)))
    assert_true(Franc.new(5).equals(Franc.new(5)))
    assert_false(Franc.new(5).equals(Franc.new(8)))
  end
```

이제 Franc 의 amount 필드를 제거하자 

```ruby
require './money'
# Franc.rb
class Franc < Money

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Franc.new(amount * multiplier)
  end
end

```

Fran 임시 변수 선언 부분 변경하기. 

> 위와 동일하게 패스. 임시 변수 이름만 변경하였다. 

```ruby
  def equals(object)
    franc = object.amount()
    amount == franc
  end
  ...
    def equals(object)
    money = object.amount()
    amount == money
  end
```

### 요약

- 클래스 상속
- 중복 메서드 일치시킴

## issue

- protected 로 바꾸라 하지만, 어떻게 할지 몰라서 attr_accessor 사용
- 루비는 타입 캐스팅 안해줘도 되서 안했는데, 맞는지 궁금! 