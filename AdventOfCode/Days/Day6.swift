//
//  Day6.swift
//  AdventOfCode
//

import Foundation

final class Day6: Day {
    func spawn(count: inout [Int]) {
        let zeroCount = count[0]
        for i in 1...8 {
            count[i - 1] = count[i]
        }
        count[8] = zeroCount
        count[6] += zeroCount
    }

    func part1(_ input: String) -> CustomStringConvertible {
        var count = Array(repeating: 0, count: 9)
        input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }
            .forEach { count[$0] += 1 }
        for _ in 0..<80 {
            spawn(count: &count)
        }
        return count.sum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var count = Array(repeating: 0, count: 9)
        input
            .lines
            .first!
            .split(separator: ",")
            .compactMap { Int($0) }
            .forEach { count[$0] += 1 }
        for _ in 0..<256 {
            spawn(count: &count)
        }
        return count.sum
    }
}
