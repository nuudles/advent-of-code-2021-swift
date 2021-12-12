//
//  Day12Tests.swift
//  Day12Tests
//

import XCTest

class Day12Tests: XCTestCase {
    let day = Day12()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1("""
            start-A
            start-b
            A-c
            A-b
            b-d
            A-end
            b-end
            """) as? Int,
            10
        )
        XCTAssertEqual(
            day.part1("""
            dc-end
            HN-start
            start-kj
            dc-start
            dc-HN
            LN-dc
            HN-end
            kj-sa
            kj-HN
            kj-dc
            """) as? Int,
            19
        )
        XCTAssertEqual(
            day.part1("""
            fs-end
            he-DX
            fs-he
            start-DX
            pj-DX
            end-zg
            zg-sl
            zg-pj
            pj-he
            RW-he
            fs-DX
            pj-RW
            zg-RW
            start-pj
            he-WI
            zg-he
            pj-fs
            start-RW
            """) as? Int,
            226
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2("""
            start-A
            start-b
            A-c
            A-b
            b-d
            A-end
            b-end
            """) as? Int,
            36
        )
        XCTAssertEqual(
            day.part2("""
            dc-end
            HN-start
            start-kj
            dc-start
            dc-HN
            LN-dc
            HN-end
            kj-sa
            kj-HN
            kj-dc
            """) as? Int,
            103
        )
        XCTAssertEqual(
            day.part2("""
            fs-end
            he-DX
            fs-he
            start-DX
            pj-DX
            end-zg
            zg-sl
            zg-pj
            pj-he
            RW-he
            fs-DX
            pj-RW
            zg-RW
            start-pj
            he-WI
            zg-he
            pj-fs
            start-RW
            """) as? Int,
            3509
        )
    }

}
