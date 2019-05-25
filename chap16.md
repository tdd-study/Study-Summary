# 16장. 드디어, 추상화

## 16장 목표

```
Sum.plus() 구현하기
Sum.times() 구현하기 
```

### 1. 테스트 작성하기 

```ruby
  def test_sum_plus_money
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate(:CHF, :USD, 2)
    sum = Sum.new(five_bucks, ten_francs) + five_bucks
    result = bank.reduce(sum, :USD)
    assert_equal(Money.dollar(15), result)
  end
```

의도를 들어내기 위해 명시적으로 sum 을 생성했다. 

### 2. 실행 가능하게 만들기

```ruby
  def +(addend)
    Sum.new(self, addend)
  end
```

Tdd 구현시에는 테스트 코드 줄 수와 모델 코드 줄 수가 비슷하게 끝난다.

`Sum.times` 작동하게 만들자. 

### 1. 테스트 작성하기

```ruby
  def test_sum_times
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate(:CHF, :USD, 2)
    sum = Sum.new(five_bucks, ten_francs).times() 
    result = bank.reduce(sum, :USD)
    assert_equal(Money.dollar(20), result)
  end
```

### 2. 실행 가능하게 만들기

```ruby
# class Sum
  def times(multipier)
    Sum.new(augend.times(multipier), addend.times(multiplier)))
  end

# class Money
  def times(multiplier)
    Money.new(amount * multipier, currency)
  end
```

테스트가 통과한다. 

`$5 + $5` 시 Money 반환 테스트를 만들어보자.

### 1. 테스트 작성하기

```ruby
  def test_plus_same_currency_returns_money
    sum = Money.dollar(1).plus(Money.dollar(1))
    assert_true(sum.class == Money)
  end
```

### 2. 실행 가능하게 만들기

```ruby
  def test_plus_same_currency_returns_money
    sum = Money.dollar(1) + Money.dollar(1)
    assert_equal(Money, sum.class)
  end
```

작성 실패. 삭제

## 요약

- 미래 읽을 사람을 위한 가독성을 염두한 테스트 작성
- 내 개발 스타일 비교할 수 있는 방법 제시
- 선언부 수정 > 나머지 순서
- 문제 해결을 위해 컴파일러 조언 