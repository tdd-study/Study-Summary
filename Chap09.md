# TDD - 9장. 우리가 사는 시간

currency 개념을 테스트하기 위해서 먼저 테스트를 작성합니다.

```javascript
describe("Dollar, Franc - Currency Test", function() {
  it("Dollar의 currency는 USD입니다.", function() {
    Money.franc(1)
      .currenct()
      .should.equals("USD");
  });
  it("Franc의 currency는 CHF입니다.", function() {
    Money.franc(1)
      .currenct()
      .should.equals("USD");
  });
});
```

Money에 currency 메서드를 선언하고, 두 하위 클래스에서 이를 구현하는 코드를 작성합니다.

```javascript
//Dollar
currency() {
  return "USD";
}

//Franc
currency() {
  return "CHF";
}
```

currency를 Money로 올려줍니다.

```javascript
//Money.controller.js
class Money {
  constructor(amount, currency) {
    this._amount = amount;
    this._currency = currency;
  }
...
  currency() {
    return this._currency;
  }
}
```

times의 Dollar 객체를 Money객체의 정적 메서드로 정리하여 인자를 넘겨줄 때 문제 없게 만들어줍니다.

```javascript
//Money.controller.js
class Money {
  constructor(amount, currency) {
    this._amount = amount;
    this._currency = currency;
  }

  static dollar(amount) {
    return new Dollar(amount, "USD");
  }
  static franc(amount) {
    return new Franc(amount, "CHF");
  }

  equals(object) {
    const money = object;
    return (
      this._amount === money._amount &&
      this.constructor.name === object.constructor.name
    );
  }

  currency() {
    return this._currency;
  }
}

class Dollar extends Money {
  constructor(amount, currency) {
    super(amount, currency);
  }
  times(multiplier) {
    return Money.dollar(this._amount * multiplier);
  }
  equals(object) {
    return super.equals(object);
  }
  currency() {
    return super.currency();
  }
}

class Franc extends Money {
  constructor(amount, currency) {
    super(amount, currency);
  }
  times(multiplier) {
    return Money.franc(this._amount * multiplier);
  }
  equals(object) {
    return super.equals(object);
  }
  currency() {
    return super.currency();
  }
}

module.exports = { Money };

```

times를 상위 클래스로 올리고 하위클래스들을 제거할 준비가 거의 다 되었습니다.