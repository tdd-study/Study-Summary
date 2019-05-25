# 15장. 서로 다른 통화 더하기

## 15장 목표

```
환율 다른 통화 더하기 
```

### 1. 테스트 작성하기

```ruby
  def test_mixed_addition
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate(:CHF, :USD, 2)

    result = bank.reduce(five_bucks + ten_francs, :USD)
    assert_equal(Money.dollar(10), result)
  end
```

실수를 컴파일러가 잡아줄거라 믿고, 하나씩 제대로 고치자. 

테스트 실패 이유  : 10usd 가 아닌, 15 usd. 

`sum.reduce()` 가 인자를 축약하지 않음.

```ruby
# class sum
  def reduce(bank, to_currency)
    amount = @augend.reduce(bank, to_currency).amount + @addend.reduce(bank, to_currency).amount
    Money.new(amount, to_currency)
  end
```

테스트 통과! 형 변환을 해주는데 루비는 패스. expression 와 sum에 plus 를 정의해준다. 
sum 은 stub 으로 정의.

```ruby
class Expression
  def +(addend)
    Sum.new(self, addend)
  end
end

class Sum
  attr_reader :augend, :addend

  def initialize(augend, addend)
    @augend = augend
    @addend = addend
  end

  def reduce(bank, to_currency)
    amount = @augend.reduce(bank, to_currency).amount + @addend.reduce(bank, to_currency).amount
    Money.new(amount, to_currency)
  end

  def +
    nil
  end
end
```

## 요약

- 원하는 테스트 작성, 한단계 달성
- 추상적 선언으로 일반화
- 변경 후 컴파일러 지시 따르기 