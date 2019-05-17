const should = require('chai').should()

class Money {
  #amount = 0
  #currency = ''

  constructor(amount, currency){
    this.#amount = amount
    this.#currency = currency
  }
  get amountValue() {
    return this.#amount
  }
  get currencyType() {
    return this.#currency
  }
  equals(anotherObject){
    return this.amountValue === anotherObject.amountValue
        && this.currencyType === anotherObject.currencyType
  }
  times(multiplier){
    return new Money(this.amountValue * multiplier, this.currencyType);
  }
  static dollar(amount) {
    return new Money(amount, 'USD')
  }
  static franc(amount) {
    return new Money(amount, 'CHF')
  }
}

describe('Multi-currency Test', () => {
  it('multiply dollar', () => {
    const five = Money.dollar(5);
    Money.dollar(10).amountValue.should.deep.equal(five.times(2).amountValue);
    Money.dollar(15).amountValue.should.deep.equal(five.times(3).amountValue);
  })
  it('test equality', () => {
    Money.dollar(5).equals(Money.dollar(5)).should.equals(true);
    Money.dollar(5).equals(Money.dollar(6)).should.equals(false);
    Money.dollar(5).equals(Money.franc(5)).should.equals(false);
  })
  it('test currency', () => {
    Money.dollar(1).currencyType.should.equals('USD')
    Money.franc(1).currencyType.should.equals('CHF')
  })
})