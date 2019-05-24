# TDD - 8장. 객체 만들기

이제 times메서드만 Money로 옮긴다면 Fran과 Dollar의 할 일이 없어지고 두 클래스를 삭제할 수 있을 것입니다.

Moneydp Dollar를 반환하는 팩토리 메서드를 도입합니다.

다음과 같은 테스트로 작동할 예정입니다.

```javascript
describe("Dollar - testMultiplication()", function() {
  const five = Money.dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(new Dollar(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(new Dollar(15));
  });
});
```

정적 메소드로 생성하고, Dollar 객체를 반환하는 메서드를 작성하면 다음과같습니다.

```javascript
static dollar(amount) {
  return new Dollar(amount);
}
```

추가로 franc과 관련된 메서드를 마저 만들어 줍니다.

```javascript
static franc(amount) {
  return new Franc(amount);
}
```

테스트 역시 Dollar객체를 Money.dollar로 모두 바꿔줍니다.

현재까지 최종적으로는 다음과 같습니다. 여기까지 테스트를 올바르게 통과하고 있습니다.

```javascript
//Money.controller.js
class Money {
  constructor(amount) {
    this._amount = amount;
  }

  static dollar(amount) {
    return new Dollar(amount);
  }
  static franc(amount) {
    return new Franc(amount);
  }

  equals(object) {
    const money = object;
    return (
      this._amount === money._amount &&
      this.constructor.name === object.constructor.name
    );
  }
}

class Dollar extends Money {
  constructor(amount) {
    super(amount);
  }
  times(multiplier) {
    return new Dollar(this._amount * multiplier);
  }
  equals(object) {
    return super.equals(object);
  }
}

class Franc extends Money {
  constructor(amount) {
    super(amount);
  }
  times(multiplier) {
    return new Franc(this._amount * multiplier);
  }
  equals(object) {
    return super.equals(object);
  }
}

module.exports = { Money };

```

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Money = Module.Money;

describe("Dollar - testMultiplication()", function() {
  const five = Money.dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(Money.dollar(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(Money.dollar(15));
  });
});

describe("Dollar - testEquality()", function() {
  it("return값이 true입니다.", function() {
    Money.dollar(5).equals(Money.dollar(5)).should.be.true;
  });
  it("return값이 false입니다.", function() {
    Money.dollar(5).equals(Money.dollar(6)).should.be.false;
  });
});

describe("Franc - testFrancMultiplication()", function() {
  const five = Money.franc(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(Money.franc(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(Money.franc(15));
  });
});

describe("Franc - testEquality()", function() {
  it("return값이 true입니다.", function() {
    Money.franc(5).equals(Money.franc(5)).should.be.true;
  });
  it("return값이 false입니다.", function() {
    Money.franc(5).equals(Money.franc(6)).should.be.false;
  });
});

describe("Dollar, Franc - testEquality()", function() {
  it("return값이 false입니다.", function() {
    Money.franc(5).equals(Money.dollar(5)).should.be.false;
  });
});

```

