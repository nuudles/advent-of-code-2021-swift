//
//  Day21Tests.swift
//  Day21Tests
//

import XCTest

class Day21Tests: XCTestCase {
    let day = Day21()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            Player 1 starting position: 4
            Player 2 starting position: 8
            """) as? Int,
            739785
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            Player 1 starting position: 4
            Player 2 starting position: 8
            """) as? Int,
            444356092776315
        )
    }

}
