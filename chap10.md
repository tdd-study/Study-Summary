# 10장 흥미로운 시간 

## 10장 목표

```
times 메서드를 상위클래스로 옮겨보자
```

동일하게 만들기 위해, 이전에 만들었던걸 뒤로 돌려보자. 

```ruby
  # class Franc
  def times(multiplier)
    Franc.new(amount * multiplier, nil)
  end
  # class Dollar
  def times(multiplier)
    Dollar.new(amount * multiplier, nil)
  end
```

currency 를 넣어보자. 

```ruby
  # class Franc
  def times(multiplier)
    Franc.new(amount * multiplier, :CHF)
  end
  # class Dollar
  def times(multiplier)
    Dollar.new(amount * multiplier, :USD)
  end
```

변수로 변경

```ruby
  # class Franc
  def times(multiplier)
    Franc.new(amount * multiplier, currency)
  end
  # class Dollar
  def times(multiplier)
    Dollar.new(amount * multiplier, currency)
  end
```

Money 반환으로 고치기

```ruby
  # class Franc
  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end
  # class Money
  def times(amount)
    nil
  end
```

toString 정의은 패스했다. 

error 에 대해 equals 구현을 변경하기라고 하는데, 이게 예전 런타임 에러에서 나왔던 것 같다. 하지만 이렇게하면 currency 여부가 같은지 알 수 없다. 

다시, Franc 를 반환하게 하자

```ruby
  def times(multiplier)
    Franc.new(amount * multiplier, currency)
  end
```

테스트를 변경하자

### 1. 테스트 작성하기

```ruby
  def test_differenct_class_equality
    assert_true(Money.new(10,:CHF).equals(Franc.new(10,:CHF)))
  end
```

다른 테스트들이 에러나는데, 일단 주석처리하고 테스트중. equals 변경

```ruby
  # class Money 
  def equals(money)
    amount == money.amount && currency == money.currency
  end
```

Money 반환. Dollar 도 동일 변경 

```ruby
  # class Franc
  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end

  # class Dollar
  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end
```

상위 클래스로 올리기 

```ruby
  def times(multiplier)
    Money.new(amount * multiplier, currency)
  end
```

## 요약

- 하위 클래스 제거 가능
- times() 메서드 일치를 위해, 상수 -> 변수 변경
- 디버깅을 위한 메서드 작성
- 계속 번복하며 테스트 작성 