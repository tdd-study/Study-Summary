# TDD - 5장. 솔직히 말하자

첫번째 테스트에 대해서는 아직 접근조차 하지 않았었는데 이를 통째로, 한꺼번에 구현하기에는 어려움이 있습니다.

조금 작은 단계로 나누어 개발해보려 합니다. 우선 Dollar 테스트를 복사하고 수정합니다.

```javascript
describe("testFrancMultiplication()", function() {
  const five = new Franc(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(new Franc(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(new Franc(15));
  });
});
```

우리가 지금껏 TDD의 주기는 다음과 같았습니다.

1. 테스트 작성
2. 컴파일되게 하기
3. 실패하는지 확인하기 위해 실행
4. 실행하게 만듦
5. 중복 제거

각 단계에는 서로 다른 목적이 있습니다. 처음 네 단계는 빠르게 진행해야합니다.

주기의 다섯번째 단계없이는 앞의 네 단계는 제대로 이루어지지 않습니다. 

적절한 시기에 적절한 설계를 돌아가게 만들고 올바르게 만들어야합니다.

다음과 같이 Franc 객체를 만들어줍니다.

```javascript

class Franc {
  constructor(amount) {
    this._amount = amount;
  }
  times(multiplier) {
    return new Franc(this._amount * multiplier);
  }
  equals(object) {
    const franc = object;
    return this._amount === franc._amount;
  }
}

module.exports = { Dollar, Franc };

```

