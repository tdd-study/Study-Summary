# TDD - 7장. 사과와 오렌지

Franc와 Dollar를 비교하는 테스트를 작성합니다.

```javascript
describe("Dollar, Franc - testEquality()", function() {
  it("return값이 false입니다.", function() {
    new Franc(5).equals(new Dollar(5)).should.be.false;
  });
});

```

dollor과 franc가 동일하게 나옵니다.

두 클래스 이름이 동일한지를 비교하는 코드를 작성하여 테스트를 통과하게 합니다.

```javascript
equals(object) {
  const money = object;
  return this._amount === money._amount && this.constructor.name === object.constructor.name;
}
```

테스트를 통과하는 것을 확인할 수 있습니다.