//
//  Day14Tests.swift
//  Day14Tests
//

import XCTest

class Day14Tests: XCTestCase {
    let day = Day14()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            NNCB

            CH -> B
            HH -> N
            CB -> H
            NH -> C
            HB -> C
            HC -> B
            HN -> C
            NN -> C
            BH -> H
            NC -> B
            NB -> B
            BN -> B
            BB -> N
            BC -> B
            CC -> N
            CN -> C
            """) as? Int,
            1588
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            NNCB

            CH -> B
            HH -> N
            CB -> H
            NH -> C
            HB -> C
            HC -> B
            HN -> C
            NN -> C
            BH -> H
            NC -> B
            NB -> B
            BN -> B
            BB -> N
            BC -> B
            CC -> N
            CN -> C
            """) as? Int,
            2188189693529
        )
    }

}
