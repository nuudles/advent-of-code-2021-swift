//
//  Day16Tests.swift
//  Day16Tests
//

import XCTest

class Day16Tests: XCTestCase {
    let day = Day16()

    func testPart1() throws {
        XCTAssertEqual(day.part1("D2FE28") as? Int, 6)
        XCTAssertEqual(day.part1("38006F45291200") as? Int, 9)
        XCTAssertEqual(day.part1("EE00D40C823060") as? Int, 14)
        XCTAssertEqual(day.part1("8A004A801A8002F478") as? Int, 16)
    }

    func testPart2() throws {
        XCTAssertEqual(day.part2("C200B40A82") as? Int, 3)
        XCTAssertEqual(day.part2("04005AC33890") as? Int, 54)
        XCTAssertEqual(day.part2("880086C3E88112") as? Int, 7)
        XCTAssertEqual(day.part2("CE00C43D881120") as? Int, 9)
        XCTAssertEqual(day.part2("D8005AC2A8F0") as? Int, 1)
        XCTAssertEqual(day.part2("F600BC2D8F") as? Int, 0)
        XCTAssertEqual(day.part2("9C005AC2F8F0") as? Int, 0)
        XCTAssertEqual(day.part2("9C0141080250320F1802104A08") as? Int, 1)
    }
}
