//
//  TDD_PracticeTests.swift
//  TDD PracticeTests
//
//  Created by 이동건 on 17/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import XCTest
@testable import TDD_Practice

class Dollar {
    var amount: Int
    
    init(_ amount: Int) {
        self.amount = amount
    }
    
    func times(_ multiplier: Int) -> Dollar {
        return Dollar(amount * multiplier)
    }
    
    func equals(_ dollar: Dollar) -> Bool {
        return amount == dollar.amount
    }
}

extension Dollar: Equatable {
    static func == (lhs: Dollar, rhs: Dollar) -> Bool {
        return lhs.amount == rhs.amount
    }
}

class Franc {
    var amount: Int
    
    init(_ amount: Int) {
        self.amount = amount
    }
    
    func times(_ multiplier: Int) -> Franc {
        return Franc(amount * multiplier)
    }
    
    func equals(_ dollar: Franc) -> Bool {
        return amount == dollar.amount
    }
}

extension Franc: Equatable {
    static func == (lhs: Franc, rhs: Franc) -> Bool {
        return lhs.amount == rhs.amount
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
