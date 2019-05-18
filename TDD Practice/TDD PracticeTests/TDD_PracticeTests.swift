//
//  TDD_PracticeTests.swift
//  TDD PracticeTests
//
//  Created by 이동건 on 17/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import XCTest
@testable import TDD_Practice

class Money {
    fileprivate var amount: Int
    
    init(_ amount: Int) {
        self.amount = amount
    }
}

extension Money: Equatable {
    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount
    }
}

class Dollar: Money {
    func times(_ multiplier: Int) -> Dollar {
        return Dollar(amount * multiplier)
    }
    
    func equals(_ dollar: Dollar) -> Bool {
        return amount == dollar.amount
    }
}

class Franc: Money {
    func times(_ multiplier: Int) -> Franc {
        return Franc(amount * multiplier)
    }
    
    func equals(_ dollar: Franc) -> Bool {
        return amount == dollar.amount
    }
}

class TDD_PracticeTests: XCTestCase {

    func testMultiplication() {
        let five: Dollar = Dollar(5)
        XCTAssertEqual(Dollar(10), five.times(2))
        XCTAssertEqual(Dollar(15), five.times(3))
    }
    
    func testEquality() {
        XCTAssertTrue(Dollar(5).equals(Dollar(5)))
        XCTAssertFalse(Dollar(5).equals(Dollar(6)))
    }
    
    func testFrancMultiplication() {
        let five: Franc = Franc(5)
        XCTAssertEqual(Franc(10), five.times(2))
        XCTAssertEqual(Franc(15), five.times(3))
    }
}
