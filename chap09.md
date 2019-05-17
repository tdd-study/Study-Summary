# 9장 우리가 사는 시간

## 9장 목표

```
통화 개념 도입
```

### 1. 테스트 작성하기

```ruby
def test_currency()
  assertEquals("USD", Money.dollar(1).currency)
  assertEquals("CHF", Money.franc(1).currency)
end
```

### 2. 실행 가능하게 만들기

`currency()` 메서드 선언

```ruby
# Money
class Money

  def equals(money)
    (amount == money.amount && (self.class.equal?(money.class)))
  end

  def self.dollar(amount)
    Dollar.new(amount)
  end

  def self.franc(amount)
    Franc.new(amount)
  end

  protected
  attr_accessor :amount
  attr_accessor :currency
end
```

```ruby
# Dollar
require './money'
# Dollar.rb
class Dollar < Money
  # attr_accessor :amount

  def currency
    "USD"
  end
  ...
end
```

```ruby 
require './money'
# Franc.rb
class Franc < Money
  # attr_accessor :amount

  def currency
    "CHF"
  end

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Franc.new(amount * multiplier)
  end
end
```

통화를 인스턴스 변수에 저장하고, 반환하는 메서드를 만들자. 

```ruby
# Franc.rb
class Franc < Money
  attr_accessor :amount
  attr_reader :currency

  def initialize(amount)
    @amount = amount
    @currency = :CHF
  end

  def times(multiplier)
    Franc.new(amount * multiplier)
  end
end
```

```ruby
# Dollar.rb
class Dollar < Money
  attr_accessor :amount
  attr_reader :currency

  def initialize(amount)
    @amount = amount
    @currency = :USD
  end

  def times(multiplier)
    Dollar.new(amount * multiplier)
  end
end
```

두 `currency()` 가 동일하다. Money 로 올리자. 여기서 에러나서 찾아봤더니, 루비 모든 인스턴스 변수는 `protected` 라고 한다. 다시 진행.

```ruby
class Money
  attr_accessor :amount
  attr_accessor :currency
  
  def equals(money)
    (amount == money.amount && (self.class.equal?(money.class)))
  end

  def self.dollar(amount)
    Dollar.new(amount)
  end

  def self.franc(amount)
    Franc.new(amount)
  end
end
```

USD 와 CHF 를 메섣드로 옮기자. 생성자 인자 추가하기

```ruby
require './money'
# Franc.rb
class Franc < Money

  def initialize(amount, currency)
    @amount = amount
    @currency = :CHF
  end

  def times(multiplier)
    Franc.new(amount * multiplier)
  end
end
```

생성자 호출하는 두 곳이 깨진다고 한다..ide 로 작업하는게 아니라 모르겠지만 진행해보자. 

```ruby
  # class Money 
  def self.franc(amount)
    Franc.new(amount, nil)
  end

  # Func.times
  def self.franc(amount)
    Franc.new(amount, nil)
  end
```

times 정리

```ruby
  def times(multiplier)
    Money.franc(amount * multiplier, nil)
  end
```

"CHF" 전달

```ruby
  # class Money
  def self.franc(amount)
    Franc.new(amount, :CHF)
  end
```

인스턴스 변수 할당 

```ruby
  # Franc
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end
```

Dollar 수정

```ruby
  # Money.rb
  def self.dollar(amount)
    Dollar.new(amount, :USD)
  end

  # Dollar.rb
  class Dollar < Money
    def initialize(amount,currency)
      @amount = amount
      @currency = currency
    end
  
    def times(multiplier)
      Money.dollar(amount * multiplier)
    end
  end
```

생성자가 동일해 졌으니, 상위 코드에 올리자. 

```ruby
# Money class
class Money
  attr_accessor :amount
  attr_accessor :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def equals(money)
    (amount == money.amount && (self.class.equal?(money.class)))
  end

  def self.dollar(amount)
    Dollar.new(amount,:USD)
  end

  def self.franc(amount)
    Franc.new(amount, :CHF)
  end
end

# Franc.rb
class Franc < Money
  def initialize(amount, currency)
    super(amount, currency)
  end

  def times(multiplier)
    Money.franc(amount * multiplier)
  end
end


# Dollar.rb
class Dollar < Money
  def initialize(amount, currency)
    super(amount, currency)
  end

  def times(multiplier)
    Money.dollar(amount * multiplier)
  end
end
```

## 요약

- 작은 작업을 먼저 수행
- 팩토리 메서드를 사용하여 생성자를 일치시킴