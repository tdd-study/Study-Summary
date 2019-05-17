# TDD - 2장. 타락한 객체

### 작동하는 깔끔한 코드

우리가 TDD를 하는 목적은 '작동하는 깔끔한 코드를 얻는 것'입니다. 

이를 위해서 divide and conquer(나누어서 정복)방식을 이용합니다.

'작동하는 깔끔한 코드'에서 '작동하는'에 해당하는 부분을 먼저 해결하고 '깔끔한 코드' 부분을 해결합니다.

이제 아까의 투두리스트를 조금 더 확대합니다.

> \$5 + 10CHF = \$10(환율이 2:1인 경우)
>
> ~~\$5 X 2 = \$10~~
>
> amount를 private로 만들기
>
> **Dollar 부작용**
>
> Money 반올림

### 

### 다른 케이스 추가

아까의 코드에 이어서 이번에는 Dollar 객체의 문제점을 수정해보려고 합니다. 

현재 Dollar에 대해 연산을 수행한 이후에 해당 Dollar의 값이 바뀌는 문제가 있습니다.

따라서, 두번째 테스트를 실패하게 됩니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
let Dollar = Module.Dollar;

describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2);
    five.amount.should.equals(10);
  });

  it("retrun 값은 15이어야 합니다.", function() {
    five.times(3);
    five.amount.should.equals(15);
  });
});
```

```bash
  testMultiplication()
    ✓ retrun 값은 10이어야 합니다.
    1) retrun 값은 15이어야 합니다.


  1 passing (12ms)
  1 failing

  1) testMultiplication()
       retrun 값은 15이어야 합니다.:

      AssertionError: expected 30 to equal 15
      + expected - actual

      -30
      +15
      
      at Context.<anonymous> (test/Money.controller.spec.js:15:24)
```

 이를 해결하기 위해 테스트 코드와 Dollar.times()를 수정합니다. 새로운 객체를 반환하여 원래 5달러를 변경하지 않도록 합니다.

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
```

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this.amount = amount;
  }
  times(multiplier) {
    return new Dollar(this.amount * multiplier);
  }
}

module.exports = { Dollar };

```

```bash
 testMultiplication()
    ✓ retrun 값은 10이어야 합니다.
    ✓ retrun 값은 15이어야 합니다.


  2 passing (10ms)
```

테스트를 통과하기 위해 가짜 구현으로 시작해서 점차 실제 구현을 만들어 갑니다.



### 빠르게 초록색을 보는 방법

최대한 빠르게 초록색을 보기 위해서 책에서는 세 가지 전략을 제시합니다.

1. 가짜로 구현하기
2. 명백한 구현 사용하기
3. 삼각측량

위의 방법 중 1과 2의 경우, 상황에 따라 전략을 섞어서 씁니다. 

* 입력해야 하는 값을 명백히 알 때는 명백한 구현을 사용합니다.
* 예상치 못한 빨간 막대를 만나게 되면 가짜로 구현하기 방법을 사용하여 올바른 코드로 리팩토링 합니다.

