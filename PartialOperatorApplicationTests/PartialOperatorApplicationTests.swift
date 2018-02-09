//
//  PartialOperatorApplicationTests.swift
//  PartialOperatorApplicationTests
//
//  Created by Michael Pangburn on 2/5/18.
//  Copyright © 2018 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import PartialOperatorApplication

class PartialOperatorApplicationTests: XCTestCase {

    class Reference: Equatable {
        static func == (lhs: Reference, rhs: Reference) -> Bool {
            return lhs === rhs
        }
    }
    
    func testPartialEquality() {
        let numbers = [1, 2, 3, 3, 3, 4, 5]
        XCTAssert(numbers.filter(==3) == [3, 3, 3])
        XCTAssert(numbers.filter(3==) == [3, 3, 3])
        XCTAssert(numbers.filter(!=3) == [1, 2, 4, 5])
        XCTAssert(numbers.filter(~=3) == [3, 3, 3])
        XCTAssert(numbers.filter(3~=) == [3, 3, 3])
    }

    func testPartialIdentityEquality() {
        let (firstReference, secondReference) = (Reference(), Reference())
        let dummies = [firstReference, firstReference, secondReference, secondReference]
        XCTAssert(dummies.filter(===firstReference) == [firstReference, firstReference])
        XCTAssert(dummies.filter(firstReference===) == [firstReference, firstReference])
        XCTAssert(dummies.filter(!==firstReference) == [secondReference, secondReference])
    }

    func testPartialComparison() {
        let numbers = Array(1...10)
        XCTAssert(numbers.filter(>5) == Array(6...10))
        XCTAssert(numbers.filter(5<=) == Array(5...10))
        XCTAssert(numbers.filter(>=8) == Array(8...10))
        XCTAssert(numbers.filter(8<) == Array(9...10))
        XCTAssert(numbers.filter(<=3) == Array(1...3))
        XCTAssert(numbers.filter(3>=) == Array(1...3))
    }

    func testPartialNumericOperations() {
        let numbers = Array(1...10)
        XCTAssert(numbers.map(+2) == Array(3...12))
        XCTAssert(numbers.map(2+) == Array(3...12))
        XCTAssert(numbers.map(11-) == Array(1...10).reversed())
        XCTAssert(numbers.map(*2) == Array(stride(from: 2, through: 20, by: 2)))
        XCTAssert(numbers.map(2*) == Array(stride(from: 2, through: 20, by: 2)))
    }

    func testPartialFloatingPointOperations() {
        let numbers = Array(stride(from: 1.0, through: 5.0, by: 1.0))
        XCTAssert(numbers.map(/2) == Array(stride(from: 0.5, through: 2.5, by: 0.5)))
        XCTAssert(numbers.map(2/) == [2.0, 1.0, 2.0 / 3.0, 0.5, 0.4])
    }

    func testPartialBinaryIntegerOperations() {
        let numbers = Array(1...5)
        XCTAssert(numbers.map(/2) == [0, 1, 1, 2, 2])
        XCTAssert(numbers.map(%2) == [1, 0, 1, 0, 1])
        let factorsOfTwelve = [1, 2, 3, 4, 6, 12]
        XCTAssert(factorsOfTwelve.map(12/) == Array(factorsOfTwelve).reversed())
        XCTAssert(factorsOfTwelve.map(10%) == [0, 0, 1, 2, 4, 10])
    }

    func testPartialBoolOperations() {
        let bools = [true, false, true, false]
        XCTAssert(bools.map(&&true) == bools)
        XCTAssert(bools.map(true&&) == bools)
        XCTAssert(bools.map(&&false) == Array(repeating: false, count: bools.count))
        XCTAssert(bools.map(false&&) == Array(repeating: false, count: bools.count))
        XCTAssert(bools.map(||true) == Array(repeating: true, count: bools.count))
        XCTAssert(bools.map(true||) == Array(repeating: true, count: bools.count))
        XCTAssert(bools.map(||false) == bools)
        XCTAssert(bools.map(false||) == bools)
    }

    func testPartialNilCoalescing() {
        let maybeNumbers: [Int?] = [1, 2, nil, 4, nil, 6]
        XCTAssert(maybeNumbers.map(??100) == [1, 2, 100, 4, 100, 6])
    }

    func testPartialsInSwitch() {
        func signum(_ x: Int) -> Int {
            switch x {
            case not(>=0):
                return -1
            case ==0:
                return 0
            case >0:
                return 1
            default:
                fatalError()
            }
        }

        XCTAssert(signum(-5) == -1)
        XCTAssert(signum(0) == 0)
        XCTAssert(signum(3) == 1)
    }
}
