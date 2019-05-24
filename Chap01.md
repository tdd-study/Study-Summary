# TDD - 1장. 다중 통화를 지원하는 Money 객체

<br>

## 테스트 주도 개발 맛보기

화폐 예제를 이용하여 차례차례 테스트 주도 개발의 세부적인 과정에 대해서 학습해보려고 합니다.

### TDD의 시작

TDD의 주요 흐름은 다음과 같습니다.

1. 테스트를 하나 추가함
2. 모든 테스트를 실행하고 새로 추가한 것이 실패하는지 확인
3. 코드를 조금 바꿈(리팩토링)
4. 모든 테스트를 gg실행하고 전부 성공하는지 확인
5. 리팩토링을 통해 중복을 제거

먼저 화폐 예제 개발을 위해 필요한 Todo리스트를 작성합니다.

> \$5 + 10CHF = \$10(환율이 2:1인 경우)
>
> **\$5 X 2 = \$10**



### 테스트 생성

먼저 객체를 만드는 것이 아니라 테스트를 우선 작성합니다. 

테스트 작성을 위해서는 **Mocha**라는 유닛 테스트 툴을 이용할 것이며 `assertion`으로 **chai**를 이용합니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();
```

테스트를 작성할 때는 작은 것부터 시작하는게 좋습니다. 그게 아니라면 아예 손을 대지 않는게 좋습니다.

또한, 테스트를 작성할 때에는 메서드의 완벽한 인터페이스에 대해 상상해보는 것이 좋습니다.



앞의 Mocha를 이용하여 간단한 곱셈 예제의 테스트를 작성하면 다음과 같습니다.

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
});
```

이렇게 작성한 예제를 돌려보면 다음과 같은 이유에 의한 컴파일 에러가 예상됩니다.

* Dollar 클래스가 없음 
* 생성자가 없음
* times() 메서드가 없음
* amount 값이 없음



### 실패하는 코드 작성

이제 이 에러들을 차례로 없애보면 다음과 같습니다.

1. Dollar 클래스 생성

   ```javascript
   //Money.controller.js
   class Dollar {}
   module.exports = {Dollar};
   ```

2. 생성자 생성

   ```javascript
   //Money.controller.js
   class Dollar {
   	constructor(amount){}
   }
   module.exports = {Dollar};
   ```

3. times() 메서드 구현

   ```javascript
   //Money.controller.js
   class Dollar {
   	constructor(amount){}
   	times(multiplier){}
   }
   module.exports = {Dollar};
   ```

4. amount 변수 선언

   ```javascript
   //Money.controller.js
   class Dollar {
   	constructor(amount){
     	this.amount = amount;
     }
   	times(multiplier){}
   }
   module.exports = {Dollar};
   ```

이렇게 구현하고 나서 테스트를 돌려보면 테스트가 실패하는 것을 확인할 수 있습니다. 이 실패가 책에서 표현하는 빨간 막대 입니다. 

```bash
  0 passing (13ms)
  1 failing

  1) testMultiplication()
       retrun 값은 10이어야 합니다.:
     AssertionError: expected { amount: 10 } to equal 5
      at Context.<anonymous> (test/Money.controller.spec.js:10:27)
```



### 약간의 수정과 테스트 성공

이제 우리의 목표는 완벽한 어플리케이션 개발이 아닙니다. 이 실패한 테스트를 통과 시키는 것이 목표가 되는 것입니다.

이를 위해 다음과 같이 최소한의 작업을 해주어 테스트를 통과하도록 합니다.

```javascript
//Money.controller.spec.js
const Module = require("../Money.controller");
require("chai").should();

let Dollar = Module.Dollar;
describe("testMultiplication()", function() {
  const five = new Dollar(5);
  it("retrun 값은 10이어야 합니다.", function() {
    five.times(2);
    five.amount = 10;
    five.amount.should.equals(10);
  });
});

```

```bash
  testMultiplication()
    ✓ retrun 값은 10이어야 합니다.

  1 passing (8ms)	
```



### 중복 제거

아까의 TDD 주기 중 4번에 해당하는 항목까지 완료하였습니다. 

이제 중복을 제거합니다. 테스트 데이터와 코드 사이에 존재하는 중복을 제거합니다.

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this.amount = amount;
  }
  times(multiplier) {
    this.amount = 5 * 2;
  }
}

module.exports = { Dollar };

```

이런 단계가 작게 느껴져 이것보다는 더 진행해야 하는게 아닌가 하는 의문이 들 수 있습니다.

TDD의 핵심은 이런 작은 단계로 작업하는 방법을 배워 저절로 적절한 크기의 단계로 작업하는 것입니다.

이제 본격적으로 테스트 코드와 작업 코드 사이의 중복을 제거합니다.

```javascript
//Money.controller.js
class Dollar {
  constructor(amount) {
    this.amount = amount;
  }
  times(multiplier) {
    this.amount *= multiplier;
  }
}

module.exports = { Dollar };
```

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
});
```

이제 드디어 한 주기가 끝이 났습니다. 드디어 투두 리스트에서 한가지를 제거할 수 있습니다.

>\$5 + 10CHF = \$10(환율이 2:1인 경우)
>
>~~**\$5 X 2 = \$10**~~

