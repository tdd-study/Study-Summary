//
//  TDD_PracticeTests.swift
//  TDD PracticeTests
//
//  Created by 이동건 on 17/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import XCTest
@testable import TDD_Practice

class Money: Equatable {
    fileprivate var amount: Int
    public var currency: String
    
    init(_ amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    func times(_ by: Int) -> Money {
        fatalError("Must Override")
    }
}

extension Money {
    static func dollar(_ amount: Int) -> Money {
        return Dollar(amount, currency: "USD")
    }
    
    static func franc(_ amount: Int) -> Money {
        return Franc(amount, currency: "CHF")
    }
}

func == <T: Money>(lhs: T, rhs: T) -> Bool {
    return lhs.amount == rhs.amount
        && String(describing: lhs.self) == String(describing: rhs.self)
}

class Dollar: Money {
    override func times(_ by: Int) -> Money {
        return Money.dollar(self.amount * by)
    }
}

class Franc: Money {
    override func times(_ by: Int) -> Money {
        return Money.franc(self.amount * by)
    }
}

class DollarTests: XCTestCase {
    func testMultiplication() {
        let five = Money.dollar(5)
        XCTAssertEqual(Money.dollar(5 * 2), five.times(2))
        XCTAssertEqual(Money.dollar(5 * 3), five.times(3))
    }
    
    func testFrancMultiplication() {
        let five = Money.franc(5)
        XCTAssertEqual(Money.franc(5 * 2), five.times(2))
        XCTAssertEqual(Money.franc(5 * 3), five.times(3))
    }
    
    func testEquality() {
        XCTAssertEqual(Money.dollar(5), Money.dollar(5))
        XCTAssertNotEqual(Money.dollar(5), Money.dollar(6))
        XCTAssertEqual(Money.franc(5), Money.franc(5))
        XCTAssertNotEqual(Money.franc(5), Money.franc(6))
        XCTAssertNotEqual(Money.dollar(5), Money.franc(5))
    }
    
    func testCurrency() {
        XCTAssertEqual("USD", Money.dollar(1).currency);
        XCTAssertEqual("CHF", Money.franc(1).currency);
    }
}
