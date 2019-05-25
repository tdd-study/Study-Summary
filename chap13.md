# 13장 진짜로 만들기

## 13장 목표

```
더하기 리팩토링
```

중복을 제거해야한다. `$5 + $5 = $10` 테스트에 완료 표시를 할 수 없다. 

### 1. 테스트 작성하기 

```ruby
  def test_plus_returns_sum
    five = Money.dollar(5)
    result = five.plus(five)
    sum = result
    assert_equal(five, sum.augend)
    assert_equal(five, sum.gddend)
  end
```

### 2. 실행 가능하게 만들기

class sum 만들기, 생성자 생성

```ruby
class Sum
  attr_accessor :augend, :addend 
  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end
end
```

money plus 메서드 변경

```ruby
  def plus(other)
    Sum.new(self, other)
  end
```

sum 내 money 가 amount 값을 갖는 Money 객체여야 한다. 

```ruby
  def test_reduce_sum
    sum = Sum.new(Money.dollar(3), Money.dollar(4))
    bank = Bank.new()
    result = bank.reduce(sum,:USD)
    assert_equal(Money.dollar(7), result)
  end
```

bank.reduce() 는 sum 을 반환. sum 이 가지는 money 통화가 동일하면, sum 내 money 의 amount 값이 합친 값을 갖는 money 객체여야 한다.

```ruby
class Bank
  def reduce(source, to)
    sum = source
    amount = sum.augend.amount + sum.addend.amount 
    Money.new(amount, to)
  end
end
```

캐스팅 / public 에 대한 지저분함을 고쳐보자. 

```ruby
class Bank
  def reduce(source, to)
    sum = source
    sum.reduce(to)
  end
end
```

reduce 를 sum 으로 옮긴다

```ruby
class Sum
  attr_accessor :augend, :addend 
  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(to)
    amount = augent.amount + addend.amount
    Money.new(amount,to)
  end
end
```

테스트 작성

```ruby
  def test_reduce_money
    bank = Bank.new()
    result = bank.reduce(Money.dollar(1), :USD)
    assert_equal(Money.dollar(1), result)
  end
```

```ruby
class Bank
  def reduce(source, to)
    return source if source.class == Money
    sum = source
    sum.reduce(to)
  end
end
```

지저분함. 다형성을 사용해 바꾸자. 

```ruby
class Bank
  def reduce(source, to)
    source.reduce(to)
  end
end
```

중간에 빠진것들이 많아 다시 고치느라 완료된 코드

```ruby
require './money'
require 'test/unit'

# DollarTests
class DollarTests < Test::Unit::TestCase
  def test_multiplication
    five = Money.dollar(5)
    assert_equal(Money.dollar(10).amount, five.times(2).amount)
    assert_equal(Money.dollar(15).amount, five.times(3).amount)
  end

#   def test_differenct_class_equality
#     assert_true(Money.new(10,"CHF").equals(Franc.new(10,"CHF")))
#   end

  def test_simple_addition
    five = Money.dollar(5)
    sum = five.plus(five)
    bank = Bank.new
    reduced = bank.reduce(sum, :USD)
    assert_equal(Money.dollar(10).amount, reduced.amount)
  end

  def test_plus_returns_sum
    five = Money.dollar(5)
    result = five.plus(five)
    sum = result
    assert_equal(five, sum.augend)
    assert_equal(five, sum.addend)
  end

  def test_reduce_money
    bank = Bank.new()
    result = bank.reduce(Money.dollar(1), :USD)
    assert_equal(Money.dollar(1).amount, result.amount)
  end

  def test_reduce_sum
    sum = Sum.new(Money.dollar(3), Money.dollar(4))
    bank = Bank.new()
    result = bank.reduce(sum,:USD)
    assert_equal(Money.dollar(7).amount, result.amount)
  end

  def test_fran_multiplication
    five = Money.franc(5)
    assert_equal(Money.franc(10).amount, five.times(2).amount)
    assert_equal(Money.franc(15).amount, five.times(3).amount)
  end

  def test_equality
    assert_true(Money.dollar(5).equals(Money.dollar(5)))
    assert_false(Money.franc(5).equals(Money.franc(8)))
    assert_false(Money.franc(5).equals(Money.dollar(8)))
  end

  def test_currency
    assert_equal(:USD, Money.dollar(1).currency)
    assert_equal(:CHF, Money.franc(1).currency)
  end
end
```

```ruby
# Money class
class Money
  attr_accessor :amount
  attr_accessor :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def self.dollar(amount)
    Money.new(amount, :USD)
  end

  def self.franc(amount)
    Money.new(amount, :CHF)
  end

  def equals(money)
    amount == money.amount && currency == money.currency
  end

  def plus(other)
    Sum.new(self, other)
  end

  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end

  def to_string
    @amount +  " " + currency
  end



 




  def reduce(to)
    self
  end
end

class Expression
end

class Bank
  def reduce(source, to)
    source.reduce(to)
  end
end

class Sum
  attr_accessor :augend, :addend
  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(to)
    amount = @augend.amount + @addend.amount
    Money.new(amount, to)
  end
end
```

## 요약

- 중복 제거 전까지, 테스트 통과 x
- 순방향 작업
- sum의 생성을 강요하기 위한 테스트 작성
- 빠른 속도로 구현 시작
- 명시적인 클래스 검사를 위한 다형성 사용