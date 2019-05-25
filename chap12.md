# 12장 드디어, 더하기 

## 12장 목표

```
전체 더하기 기능 만들기
```

### 1. 테스트 작성하기

```ruby
  def test_simple_addition
    sum = Money.dollar(5).plus(Money.dollar(5))
    assert_equal(Money.dollar(10), sum)
  end
```

money.rb

```ruby
  def plus(addend)
    Money.new(amount + addend.amount, currency)
  end
```

__problem__

다중 통화 사용에 대한 내용을 시스템 나머지 코드에 숨기고 싶지만, 어려움

__solve__

메타포 

1. 두 Money 의 합을 나타내는 객체 만들기. 여러 화패들이 들어갈 수 있음 
2. 수식. 여러 수식을 통해 단일 통화로 축약 

메타포를 테스트 해보자. 

```ruby
  def test_simple_addition
    sum = Money.dollar(5).plus(Money.dollar(5))
    assert_equal(Money.dollar(10), sum)

    reduced =  Money.dollar(5).reduce(Money.dollar(5))
    assert_equal(Money.dollar(10), reduced)
  end
```

- 핵심 객체는 다른 곳에 영향을 받아야한다. 

```ruby
def test_simple_addition
    sum = Money.dollar(5).plus(Money.dollar(5))
    assert_equal(Money.dollar(10), sum)

    reduced =  Money.dollar(5).reduce(Money.dollar(5))
    assert_equal(Money.dollar(10), reduced)

    bank = Bank.new()
    reduced = bank.reduce(sum,"USD")
    assert_equal(Money.dollar(10),reduced)
  end
```

두 money 의 합은 expression 이어어야 한다.

```ruby
    sum = five.plus(five)
    bank = Bank.new()
    reduced = bank.reduce(sum, "USD")
    assert_equal(Money.dollar(10), reduced)
```

5$ 만들기 

```ruby
    five = Money.dollar(5)
    sum = five.plus(five)
    bank = Bank.new()
    reduced = bank.reduce(sum, "USD")
    assert_equal(Money.dollar(10), reduced)
```

### 2. 컴파일 가능하게 만들기

여기서는 인터페이스로 만들었는데 루비는 인터페이스 개념이 없는듯.. 그래서 `class` 로 만들었는데 어떻게 해야할지 모르겠다.

```ruby
class Expression
end
```

money.rb

```ruby
  # 루비에서는 그대로 
  def plus(addend)
    Money.new(amount + addend.amount, currency)
  end
```

bank.rb

```ruby
class Bank
end

# reduce 스텁 추가
class Bank
  def reduce(source, to)
    nil
  end
end
```

컴파일 실패

```ruby
class Bank
  def reduce(source, to)
    Money.dollar(10)
  end
end
```

테스트 성공!

## 요약

- 큰 테스트를 작은 테스트로 줄여서 발전 
- 계산 가능한 메타포를 생각
- 새 메타포 기반 기존 테스트를 재 작성
- 빠르게 컴파일
- 테스트 실행