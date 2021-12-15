//
//  Day15Tests.swift
//  Day15Tests
//

import XCTest

class Day15Tests: XCTestCase {
    let day = Day15()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            1163751742
            1381373672
            2136511328
            3694931569
            7463417111
            1319128137
            1359912421
            3125421639
            1293138521
            2311944581
            """) as? Int,
            40
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            1163751742
            1381373672
            2136511328
            3694931569
            7463417111
            1319128137
            1359912421
            3125421639
            1293138521
            2311944581
            """) as? Int,
            315
        )
    }

}
