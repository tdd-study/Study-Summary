# 2장 타락한 객체

## 일반적인 TDD 주기

### 방법

1. 테스트 작성
2. 실행 가능하게 만들기 
3. 올바르게 만들기

## 목적 

작동하는 깔끔한 코드를 얻자.

## 2장 목표

```
달러의 값이 변하는 점 바꾸기
```

현재 코드는 Dollar 에 대해 연산을 수행하면, 해당 Dollar 의 값이 변경된다. 즉, amount 는 무조건 5로 유지해야되지만, 현재 그게 안되는 상황.

__SOLVE__

`times()` 에서 새로운 객체를 반환하게 해버리자! 그러기 위해서, `times()` 메서드를 고칠 필요가 있다.

### 1. 테스트 작성하기

```ruby
require './Dollar'
require 'test/unit'

class DollarTests < Test::Unit::TestCase
    def test_multiplication()
        five = Dollar.new(5)
        five.times(2)
        assert_equal(10, five.amount)
        five.times(3)
        assert_equal(15, five.amount)
    end
end
```

### 2. 실행 가능하게 만들기 

```ruby
# test 1
class DollarTests < Test::Unit::TestCase
    def test_multiplication()
        five = Dollar.new(5)
        product = five.times(2)
        assert_equal(10, product.amount)
        product = five.times(3)
        assert_equal(15, product.amount)
    end
end

# => 
Error: test_multiplication(DollarTests): NoMethodError: undefined method 'amount' for 10:Integer
```

빠르게 작성한 코드에서 에러가 난다. 실행 가능하게 만들자 nil 값을 넣어 빠르게 컴파일 되게 만들어본다. 

## issue

책에서는 Java 로 진행하기 때문에 `return null` 을 넣어 실행하게 만드는데, Ruby 는 이거 또한 컴파일 에러가 난다. 루비의 특징인 모든 것은 객체이다 에서 같은 객체가 아니라 발생하는 문제 같음. 그래서 `return nil` 이 아닌 `Doller.new(0)` 으로 임시 처방을 내려줬다. 

```ruby
# test2
class Dollar
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Dollar.new(0)
    # Dollar.new(self.amount * multiplier)
  end
end

# => 
Error: test_multiplication(DollarTests): NoMethodError: undefined method `amount' for nil:NilClass
```

### 3. 올바르게 만들기

```ruby
# test3 => okay
class Dollar
  attr_accessor :amount
  def initialize(amount)
    @amount = amount
  end
  def times(multiplier)
    Dollar.new(self.amount * multiplier)
  end
end
# =>
Finished in 0.000765 seconds.
---
1 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
---
```

## 빠른 테스트 통과를 위한 2가지 전략 

1. 가짜로 구현하기
   - 상수로 반환 후 진짜 코드를 얻을 때 단계적으로 상수를 변수로 바꾼다.
2. 명백한 구현 사용하기
   - 실제 구현을 입력한다.

## 회고하기

- 설계상 결함으을 해결하기 위한 테스트 작성 (실패 테스트)
- 스텁 구현으로 빠르게 컴파일 통과 
  **stub**: 속이 빈 함수
- 올바르다 생각하는 코드를 입력하여 테스트 통과