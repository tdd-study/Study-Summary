## 8장 목표

```
Dollar/Franc 중복을 제거하자.
```

### 1. 테스트 작성하기

`times()`가 중복이다. 하위 클래스에 대한 직접적인 참조를 없애자. 팩토리 메서드를 도입해보자.

```ruby
  def test_multiplication()
    five = Money.dollar(5)
    assert_equal(Dollar.new(10).amount(), five.times(2).amount())
    assert_equal(Dollar.new(15).amount(), five.times(3).amount())
  end
```

### 2. 실행 가능하게 만들기

```ruby
# Money.rb
class Money
  attr_accessor :amount

  def equals(money)
    (amount == money.amount()) && (self.class.equal?(money.class))
  end

  def dollar(amount)
    Dollar.new(amount)
  end
end
```

달러에 대한 참조가 사라지길 원하므로, 테스트 선언부도 변경해준다는데, 루비는 런타임 환경이니 패스. abstract class 도 제공하지 않는다. 

```ruby
# Money class
class Money
  def equals(money)
    (amount == money.amount && (self.class.equal?(money.class)))
  end

  def self.dollar(amount)
    Dollar.new(amount)
  end

  protected
  attr_accessor :amount
end
```

`amount` 를 protected 로 변경했다. 테스트 코드도 변경한다.

```ruby
require './dollar'
require './franc'
require 'test/unit'

# DollarTests
class DollarTests < Test::Unit::TestCase
  def test_multiplication
    five = Money.dollar(5)
    assert_equal(Money.dollar(10).amount, five.times(2).amount)
    assert_equal(Money.dollar(15).amount, five.times(3).amount)
  end

  def test_fran_multiplication
    five = Franc.new(5)
    assert_equal(Franc.new(10).amount, five.times(2).amount)
    assert_equal(Franc.new(15).amount, five.times(3).amount)
  end

  def test_equality
    assert_true(Money.dollar(5).equals(Dollar.new(5)))
    assert_false(Money.dollar(5).equals(Dollar.new(8)))
    assert_true(Franc.new(5).equals(Franc.new(5)))
    assert_false(Franc.new(5).equals(Franc.new(8)))
    assert_false(Franc.new(5).equals(Money.dollar(8)))
  end
end
```

이제 Franc 도 변경해보자. 

```ruby
  def self.franc(amount)
    Franc.new(amount)
  end
```

```ruby
  def test_multiplication
    five = Money.dollar(5)
    assert_equal(Money.dollar(10).amount, five.times(2).amount)
    assert_equal(Money.dollar(15).amount, five.times(3).amount)
  end

  def test_fran_multiplication
    five = Franc.new(5)
    assert_equal(Money.franc(10).amount, five.times(2).amount)
    assert_equal(Money.franc(15).amount, five.times(3).amount)
  end

  def test_equality
    assert_true(Money.dollar(5).equals(Dollar.new(5)))
    assert_false(Money.dollar(5).equals(Dollar.new(8)))
    assert_true(Money.franc(5).equals(Money.franc(5)))
    assert_false(Money.franc(5).equals(Money.franc(8)))
    assert_false(Money.franc(5).equals(Money.dollar(8)))
  end
```

## 요약

- 추상화 팩토리 메서드를 사용해, 직접 참조를 제거하였다.
- `time()` 의 중복을 없앨 수 있게 만들었다.
- 메서드 선언부를 공통 상위 클래스로 이동시켰다. 

## Issue

- Money 내역을 protected :amount 로 변경하였다. 이렇게 되니, Dollar 와 Franc 에 `attr_accessor :amount ` 를 명시해야된다.  없으면 컴파일에러가 난다. 원래 위에 있는 값을 가져오는게 아닌가? 뭔가 이상함.. 

_solve_

> 찾아보니 루비는 기본적으로 모든 인스턴스 변수가 `protected` 라고 한다. 9장에서 알아서 변경. 