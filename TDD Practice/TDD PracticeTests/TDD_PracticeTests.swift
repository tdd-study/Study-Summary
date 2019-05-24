//
//  TDD_PracticeTests.swift
//  TDD PracticeTests
//
//  Created by 이동건 on 17/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import XCTest
@testable import TDD_Practice

protocol MoneyType {
    func times(_ multiplier: Int) -> Money
}

class Money: MoneyType {
    fileprivate var amount: Int
    
    init(_ amount: Int) {
        self.amount = amount
    }
    
    static func dollar(_ amount: Int) -> Money {
        return Dollar(amount)
    }
    
    static func franc(_ amount: Int) -> Money {
        return Franc(amount)
    }
    
    func times(_ multiplier: Int) -> Money {
        return Money(amount * multiplier)
    }
}

extension Money: Equatable {
    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount
    }
    
    func equals(_ money: Money) -> Bool {
        return amount == money.amount && String(describing: self) == String(describing: money)
    }
}

class Dollar: Money {
    override func times(_ multiplier: Int) -> Money {
        return Dollar(amount * multiplier)
    }
}

class Franc: Money {
    override func times(_ multiplier: Int) -> Money {
        return Franc(amount * multiplier)
    }
}

class TDD_PracticeTests: XCTestCase {

    func testMultiplication() {
        let five: Money = Money.dollar(5)
        XCTAssertEqual(Money.dollar(10), five.times(2))
        XCTAssertEqual(Money.dollar(15), five.times(3))
    }
    
    func testEquality() {
        XCTAssertTrue(Money.dollar(5).equals(Money.dollar(5)))
        XCTAssertFalse(Money.dollar(5).equals(Money.dollar(6)))
        XCTAssertTrue(Money.franc(5).equals(Money.franc(5)))
        XCTAssertFalse(Money.franc(5).equals(Money.franc(6)))
        XCTAssertFalse(Money.franc(5).equals(Money.dollar(5)))
    }
    
    func testFrancMultiplication() {
        let five: Money = Money.franc(5)
        XCTAssertEqual(Money.franc(10), five.times(2))
        XCTAssertEqual(Money.franc(15), five.times(3))
    }
}
