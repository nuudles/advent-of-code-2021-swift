//
//  Day17Tests.swift
//  Day17Tests
//

import XCTest

class Day17Tests: XCTestCase {
    let day = Day17()

    func testPart1() throws {
        XCTAssertEqual(day.part1("target area: x=20..30, y=-10..-5") as? Int, 45)
    }

    func testPart2() throws {
        debugPrint(day.part2(""))
    }

}
