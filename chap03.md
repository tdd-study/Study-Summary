---
layout: post
title: "[Ruby TDD] 루비 테스트 주도 개발 - Chap03"
author: irene
date: 2019-05-13 00:00
tags: [ruby,tdd]
image: /files/covers/tdd.png

---

# 3장 모두를 위한 평등

### 객체 패턴 (value object pattern)

인스턴스 변수가 생성자를 통해 설정되면, 이후에 절대 변하지 않는 것. 현재 예시에서 내가 5달러 객체를 만들었을때, 이 값은 절대 변하지 않아야한다. 

**값 객체 패턴의 장점**

- 별칭문제 해결 
  첫번째 값을 변경시키면, 두번째 값도 변경이 되는데, 값 객체를 사용하면 해결된다

## 3장 목표 

```
equals() 구현하기
```

`Dollar` 클래스에 값 객체 패턴을 적용시켜 보자. 이 때, 달러의 값이 변하지 않기 위해 연산은 새 객체를 반환해야 하며, 또한 다른 값과 비교해야하므로 `equals()` 함수를 필요로 한다. 

- `equals()` 구현 

### 1. 테스트 작성

```ruby
  def testEquality()
    assertTrue(Dollar.new(5).equals(Dollar.new(5)))
  end
  # =>
  NoMethodError: undefined method `equals' for #<Dollar:0x00007f9c29877bf8 @amount=5>
```

### 2. 실행 가능하게 만들기 

```ruby
# Dollar.rb
def equals(object)
  true
end
```

## 삼각측량 전략 

일반적인 해를 필요로 할 때만, 일반화 하는 방법을 써보려고 한다. 이를 위해 테스트를 하나 더 추가하자. 

```ruby
  def test_equality()
    assert_true(Dollar.new(5).equals(Dollar.new(5)))
    assert_false(Dollar.new(5).equals(Dollar.new(8)))
  end
```

이제, `eqauls()` 를 일반화를 통해 올바르게 만들어보자. 

### 3. 올바르게 만들기

```ruby
  def equals(object)
    amount == object.amount
  end
```

# 요약

#### 값 객체 패턴

생성자로 만들었을 때 값이 변하지 않게 만드는 패턴

#### 삼각 측량 전략 

여러 경우의수가 있을 경우, 일반화 하는 방법. 설계를 어떻게 할지 모를때 사용한다. 

- 객체 값이 또 다른 오퍼레이션을 암시한다는걸 알아냈다.
- 해당 오퍼레이션을 테스트했다
- 해당 오퍼레이션을 구현했다.

## issue

1. ruby 에서는 `equal?` 이라는 메서드를 제공 해주는데, 그땐바로 에러 실패가 난다. equal? 을 오버라이딩 해서 해줘야하는지? 아님 새로운 문법을 써야하는지 궁금함. 
2. 루비에서는 마지막 값이 return 값이 됨. 그래서 현재 ruby 에서는 무쓸모하다고 잡아주는데, 가독성을 위해 넣는게 날지 다들 생각이 궁금함! 해당 내용에 형변환이 있는데 루비에서 어떻게 하는지 모르겠음..

```ruby
  def equals(object)
    amount == object.amount
  end
```