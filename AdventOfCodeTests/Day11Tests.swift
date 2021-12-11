//
//  Day11Tests.swift
//  Day11Tests
//

import XCTest

class Day11Tests: XCTestCase {
    let day = Day11()

    func testPart1() throws {
//        day.part1("""
//            11111
//            19991
//            19191
//            19991
//            11111
//            """)
        XCTAssertEqual(
            day.part1("""
            5483143223
            2745854711
            5264556173
            6141336146
            6357385478
            4167524645
            2176841721
            6882881134
            4846848554
            5283751526
            """) as? Int,
            1656
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            5483143223
            2745854711
            5264556173
            6141336146
            6357385478
            4167524645
            2176841721
            6882881134
            4846848554
            5283751526
            """) as? Int,
            195
        )
    }

}
