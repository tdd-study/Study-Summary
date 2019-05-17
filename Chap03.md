# TDD - 3장. 모두를 위한 평등

### 동일성 검사

앞의 목록에서 Dollar 부작용까지 제거하였습니다.

이제는 equals()라는 것을 구현해볼 예정입니다.

>\$5 + 10CHF = \$10(환율이 2:1인 경우)
>
>~~\$5 X 2 = \$10~~
>
>amount를 private로 만들기
>
>~~Dollar 부작용~~
>
>Money 반올림
>
>**equals()**
>
>**hashCode()**

앞선 코드에서 이제는 참인지 거짓인지를 판단하는 테스트 코드를 추가합니다. 

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;

describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    let product = five.times(2);
    product.amount.should.equals(10);
  });

  it("retrun 값은 15이어야 합니다.", function() {
    product = five.times(3);
    product.amount.should.equals(15);
  });
});
describe("testEquality()", function() {
  it("return값이 true입니다.", function() {
    new Dollar(5).equals(new Dollar(5)).should.be.true;
  });
});

```

이를 가짜로 구현하여 빨간색을 제거 해줍니다.

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this.amount = amount;
  }
  times(multiplier) {
    return new Dollar(this.amount * multiplier);
  }
  equals(object) {
    return true;
  }
}

module.exports = { Dollar };
```

```bash
 testMultiplication()
    ✓ retrun 값은 10이어야 합니다.
    ✓ retrun 값은 15이어야 합니다.

  testEquality()
    ✓ return값이 true입니다.


  3 passing (8ms)
```



### 삼각측량

여기서 삼각측량을 이용해보려 합니다.

삼각측량을 이용하기 위해서는 예제가 두 개 이상 있어야만 코드를 일반화할 수 있습니다.

앞의 코드에서 삼각측량을 위해 테스트 예제를 하나 더 추가합니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;

describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    let product = five.times(2);
    product.amount.should.equals(10);
  });

  it("retrun 값은 15이어야 합니다.", function() {
    product = five.times(3);
    product.amount.should.equals(15);
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

이제 equal()함수를 앞의 두 테스트 예제를 일반화하여 리팩토링합니다. 올바르게 테스트를 통과하는 것을 볼 수 있습니다. 

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this.amount = amount;
  }
  times(multiplier) {
    return new Dollar(this.amount * multiplier);
  }
  equals(object) {
    const dollar = object;
    return this.amount === dollar.amount;
  }
}

module.exports = { Dollar };
```

이렇게 삼각층량은 코드를 어떻게 리팩토링해야 하는지 전혀 감이 안 올 때 사용합니다.

테스트와 코드 사이의 중복을 제거하고 일반화 할 수 있다면 그대로 진행하면 됩니다.

삼각층량은 문제를 다른 방향에서 생각해볼 기회도 제공합니다.