# 5장 솔직히 말하자면

## 5장 목표

  작은 테스트부터 완성하기. Dollar 객체와 비슷하게 작동하는 FRAN 객체 만들자. 

### 1. 테스트 가능하게 만들기

Dollar 복붙

```ruby
def test_fran_multiplication()
    five = Franc.new(5)
    assert_equal(Franc.new(10).amount(), five.times(2).amount())
    assert_equal(Franc.new(15).amount(), five.times(3).amount())
end
```

### 2. 컴파일 되게 하기

복붙은 안좋지만, Dollar 를 봍붙해 만들자. 

```ruby
# Franc.rb
class Franc
    attr_accessor :amount
  
    def initialize(amount)
      @amount = amount
    end
  
    def times(multiplier)
        Franc.new(amount * multiplier)
    end
  
    def equals(object)
      amount == object.amount()
    end
  end
end
```

### 3. 올바르게 만들기

중복이 엄청나게 많아, 다음 테스트 하기 전 중복을 제거해야한다. 

현재 상황

- 큰 테스트 불가. 
- 중복으로 코드 만들기 -> 테스트 통과
- 중복을 고쳐야 함 