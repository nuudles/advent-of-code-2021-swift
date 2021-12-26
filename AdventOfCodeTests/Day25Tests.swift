//
//  Day25Tests.swift
//  Day25Tests
//

import XCTest

class Day25Tests: XCTestCase {
    let day = Day25()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            v...>>.vv>
            .vv>>.vv..
            >>.>v>...v
            >>v>>.>.v.
            v>v.vv.v..
            >.>>..v...
            .vv..>.>v.
            v.v..>>v.v
            ....v..v.>
            """) as? Int,
            58
        )
    }

    func testPart2() throws {
        debugPrint(day.part2(""))
    }

}
