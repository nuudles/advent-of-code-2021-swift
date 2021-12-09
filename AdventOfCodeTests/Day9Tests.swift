//
//  Day9Tests.swift
//  Day9Tests
//

import XCTest

class Day9Tests: XCTestCase {
    let day = Day9()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            2199943210
            3987894921
            9856789892
            8767896789
            9899965678
            """) as? Int,
            15
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            2199943210
            3987894921
            9856789892
            8767896789
            9899965678
            """) as? Int,
            1134
        )
    }

}
