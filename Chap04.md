# TDD - 4장. 프라이버시

테스트가 조금 더 많은 내용을 담을 수 있도록 만들어 주려고 합니다. 

임시 변수 product를 제거합니다. 그리고 이 테스트가 어떤 의도를 가지고 작성되었는 지를 명확히 나타내게 됩니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;

describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2).should.equals(new Dollar(10));
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3).should.equals(new Dollar(15));
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

```

여기서 한가지 문제가 있습니다 Javascript의 Assert의 equal는 객체 참조값을 비교하기 때문에 동일한 값의 객체이더라도 다르다고 나오게 됩니다.

```javascript
1) testMultiplication()
       retrun 값은 10이어야 합니다.:

      AssertionError: expected { _amount: 10 } to equal { _amount: 10 }
      + expected - actual


      at Context.<anonymous> (test/Money.controller.spec.js:9:26)
```

이를 해결하기 위해 deep.equal을 사용하여 비교합니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;

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

```





### private

이렇게 테스트를 고치고 나니 Dollar의 amount변수를 사용하는 코드는 Dollar 자신 밖에 없기 때문에 변수를 private로 고쳐줍니다.

> $5 + 10CHF = \$10(환율이 2:1인 경우)
>
> ~~\$5 X 2 = \$10~~
>
> **amount를 private로 만들기**
>
> ~~Dollar 부작용~~
>
> Money 반올림
>
> ~~equals()~~
>
> hashCode()
>
> Equal null
>
> Equal object

javascript에서는 private가 따로 존재하지 않기 때문에 흉내내어 사용합니다.

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this._amount = amount;
  }
  times(multiplier) {
    return new Dollar(this._amount * multiplier);
  }
  equals(object) {
    const dollar = object;
    return this._amount === dollar._amount;
  }
}

module.exports = { Dollar };

```



### 정리

지금까지 배운 내용은 다음과 같습니다.

* 테스트를 향상시키기 위해서만 개발된 기능 사용
* 두 테스트가 동시에 실패하면 망함
* 위험 요소가 있음에도 계속 진행
* 테스트와 코드 사이의 결합도를 낮추기 위해, 테스트 하는 객체의 새 기능을 사용