# 14장. 바꾸기

## 14장 목표

```
2프랑 달러로 변환
```

### 1. 테스트 작성하기

```ruby
  def test_reduce_money_different_currency
    bank = Bank.new()
    bank.addRate(:CHF, :USD, 2)
    result = bank.reduce(Money.franc(2), :USD)
    assert_equal(Money.dollar(1).amount, result.amount)
  end
```

프라을 달러로 변환시, `1/2` 로 적용해보자. 

### 2. 실행 가능하게 만들기 

호출부분 작성  

```ruby
# class Money

  def reduce(to)
    rate = (currency.equals(:CHF) && to.equals(:USD)) ? 2 : 1
    Money.new(amount/rate, to)
  end

# class Bank

class Bank
  def reduce(source, to)
    source.reduce(self, to)
  end
end

```

구현부분 작성

```ruby
class Expression
  def reduce(bank, to)
  end
end

# class Sum
  def reduce(bank, to)
    amount = @augend.amount + @addend.amount
    Money.new(amount, to)
  end

# class Money
  def reduce(bank, to)
    rate = (currency.equals(:CHF) && to.equals(:USD)) ? 2 : 1
    Money.new(amount/rate, to)
  end

```

Moeny reduce 도 공용이어야 한다. 

```ruby 
# class Bank 
  def rate(from, to)
    from.equals(:CHF) && to.equals(:USD) ? 2: 1
  end
```

올바른 환율 물어보기

```ruby
  def reduce(bank, to)
    rate = bank.rate(currency, to)
    Money.new(amount/rate, to)
  end
```

귀찮은 2 를 없애자. 두개 통화와 환율을 맵핑시키는 클래스 만들기 

```ruby
class Pair 
  attr_accessor :from, :to
  def initialize(from, to)
    @from = from
    @to = to
  end

  def equals(object)
    pair = object
    @from.equals(pair.from) && to.equals(pair.to)
  end

  def hashcode
    0
  end
end
```

환율을 저장할 뭔가 만들기 

```ruby
# class Bank
  rate = Hashtable.new()

  def add_rate(from, to, rate)
    rates.put(Pair.new(from, to), rate.to_i)
  end
```

필요한 환율 얻어내기

```ruby
  def test_identity_rate
    assert_equal(1, Bank.new.rate(:USD, :USD))
  end
```

에러 두개 해결하기 

```ruby
# class Bank
  def rate(from, to)
    return 1 if from == to
    @rates[[from, to]]
  end
```

## 요약

- 필요한 인자 추가
- 데이터 중복 제거
- 자바 오퍼레이션 가정 검사 테스트
- 도우미 클래스 생성

## Issue

여기서부터 안되기 시작..에러를 찾을 수 없어 코드를 찾아 복사해서 나가기로했다. 
예제를 체크해봤는데, 에제 샘플에는 존재하는 `Pair` 클래스를 사용하지 않았다. 왜 그런지 한번 알아봐야 할듯!?
내용이 어려워 다시 봐야할듯!!