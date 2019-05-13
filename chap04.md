# 4장 프라이버시

## 4장 목표 

```
인스턴스 변수 프라이버시로 변경하기
```

`times()` 테스트를 명확하게 변경시켜 보자.

### 1. 테스트 가능하게 만들기

```ruby
# 1. 객체로 변경
  def test_multiplication()
    five = Dollar.new(5)
    product = five.times(2)
    assert_equal(Dollar.new(10), product.amount)
    product = five.times(3)
    assert_equal(Dollar.new(15), product.amount)
  end  

# 2. product 변수 제거 
  def test_multiplication()
    five = Dollar.new(5)
    assert_equal(Dollar.new(10), five.times(2))
    assert_equal(Dollar.new(15), five.times(3))
  end
```

amount 변수를 사용하는 코드가 `Dollar` 자신 밖에 없게 되었으므로 `private` 설정을 해줄 수 있다.

### 2. 실행 가능하게 만들기 

```ruby
# Dollar
class Dollar
  attr_accessor :amount

  def initialize(amount)
    @amount = amount
  end

  def times(multiplier)
    Dollar.new(amount * multiplier)
  end

  def equals(object)
    amount == object.amount
  end

  private :amount
end
```

## 결론

- 테스트 향상을 위한 개발된 기능을 사용했다
- 두 테스트가 동시에 실패하면 망한다.
- 위험 요소가 있음에도 계속 진행한다
- 결합도를 낮추기 위해, 객체의 새 기능을 사용한다.

## Issue

코드가 작동이 안된다.. `Dollar.new(5)` 시 객체 주소를 비교하고있다..하 