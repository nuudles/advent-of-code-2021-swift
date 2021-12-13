//
//  Day13Tests.swift
//  Day13Tests
//

import XCTest

class Day13Tests: XCTestCase {
    let day = Day13()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            6,10
            0,14
            9,10
            0,3
            10,4
            4,11
            6,0
            6,12
            4,1
            0,13
            10,12
            3,4
            3,0
            8,4
            1,10
            2,14
            8,10
            9,0

            fold along y=7
            fold along x=5
            """) as? Int,
            17
        )
    }

    func testPart2() throws {
        print(
            day.part2("""
            6,10
            0,14
            9,10
            0,3
            10,4
            4,11
            6,0
            6,12
            4,1
            0,13
            10,12
            3,4
            3,0
            8,4
            1,10
            2,14
            8,10
            9,0

            fold along y=7
            fold along x=5
            """)
        )
    }

}
