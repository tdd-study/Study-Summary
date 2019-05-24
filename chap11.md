# 11장 모든 악의 근원

## 11장 목표

```
불필요한 하위 클래스 제거 
```

Dollar,Franc 생성자 밖에 없음. 하위 클래스에 대한 참조를 상위 클래스에 대한 참조로 변경 가능하다.

Dollar,Franc 클래스 -> Money 변경

```ruby
# class Money
  def self.dollar(amount)
    Money.new(amount,:USD)
  end

  def self.franc(amount)
    Money.new(amount, :CHF)
  end
```

테스트 코드 참조를 지우기 위해 다른 동치성 테스트가 충분한지 보고, 리팩토링, `test_differenct_class_equality` 제거 

```ruby
  def test_equality
    assert_true(Money.dollar(5).equals(Money.dollar(5)))
    assert_false(Money.franc(5).equals(Money.franc(8)))
    assert_false(Money.franc(5).equals(Money.dollar(8)))
  end
```

## 요약

- 하위 클래스 속 들어내기 . 하위 클래스 삭제 
- 필요없는 소스 리팩토링

