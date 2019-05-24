# TDD - 6장. 돌아온 '모두를 위한 평등'

두 가지 비슷한 클래스를 복사하여 만들었습니다. 이제 이 두 클래스를 정리할 차례입니다.

두 클래스의 공통 상위 클래스를 만들어 주고 상속이라는 개념을 이용하여 정리하려 합니다.

`Money` 클래스를 만들고 amount 인스턴스 변수를 옮겨줍니다.

```javascript
//Money.controller.js
class Money {
  constructor(amount) {
    this._amount = amount;
  }
}

class Dollar extends Money {
  times(multiplier) {
    return new Dollar(this._amount * multiplier);
  }
  equals(object) {
    const dollar = object;
    return this._amount === dollar._amount;
  }
}
```

이제 equals를 Money로 옮겨보면 다음과 같습니다.

```javascript
//Money.controller.js
class Money {
  constructor(amount) {
    this._amount = amount;
  }
  equals(object) {
    const money = object;
    return this._amount === money._amount;
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

module.exports = { Dollar, Franc };
```

여기서 super의 쓰임이 일반적인 java와는 다르게 상속을 하고 부모 클래스에 있는 변수를 접근할 때에 this를 이용해야 합니다. 부모 클래스의 매서드를 쓸 때는 super를 사용합니다.

test를 하나 더 복사하고 돌려주면 테스트를 통과하는 것을 확인할 수 있습니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;
let Franc = Module.Franc;

describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(new Dollar(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(new Dollar(15));
  });
});

describe("testEquality()", function() {
  it("return값이 true입니다.", function() {
    new Dollar(5).equals(new Dollar(5)).should.be.true;
  });
  it("return값이 false입니다.", function() {
    new Dollar(5).equals(new Dollar(6)).should.be.false;
  });
});

describe("testFrancMultiplication()", function() {
  const five = new Franc(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.deep.equals(new Franc(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.deep.equals(new Franc(15));
  });
});

describe("testEquality()", function() {
  it("return값이 true입니다.", function() {
    new Franc(5).equals(new Franc(5)).should.be.true;
  });
  it("return값이 false입니다.", function() {
    new Franc(5).equals(new Franc(6)).should.be.false;
  });
});
```