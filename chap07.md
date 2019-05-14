# 7장 사과와 오렌지 (== 서로 다른걸 비교할 수 없다.)

## 7장 목표

```
Franc 과 dollar 과 비교되지 않는지 검사해야 한다. 금액과 클래스가 같을 경우만 같게 변경해준다. 
```

Money 클래스 변경하기

```ruby
class Money
  attr_accessor :amount

  def equals(object)
    money = object
    puts money
    puts money.class
    puts self.class
    (amount == money) && (self.class.equal?(money.class))
  end
end
```

여기서 에러를 발견. `amount()` 로 바꿔서 비교를 했는데, 여기는 클래스가 들어와야 했다. 변경 한 코드

```ruby
class Money
  attr_accessor :amount

  def equals(money)
    (amount == money.amount()) && (self.class.equal?(money.class))
  end
end
```

성공! 

### 결론 및 요약

클래스를 이렇게 사용하는건 더럽지만, 나중에 해결하자.

- times() 코드를 처리하자. 
- 결함을 테스트해서 통과했다. 
- 더 많은 동기가 있기 전에는 더 많은 설계를 도입하지 않기로 했다. 