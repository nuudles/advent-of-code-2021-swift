//
//  Day7.swift
//  AdventOfCode
//

import Foundation

final class Day7: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let crabs = input.lines.first!.split(separator: ",").compactMap { Int($0) }
        let (min, max) = (crabs.min() ?? 0, crabs.max() ?? 0)
        return (min...max)
            .map { i in crabs.reduce(0, { $0 + abs($1 - i) }) }
            .min()!
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let crabs = input.lines.first!.split(separator: ",").compactMap { Int($0) }
        let (min, max) = (crabs.min() ?? 0, crabs.max() ?? 0)
        var sum = 0
        var counts = Array<Int>()

        for i in 0...max {
            counts.append(sum + i)
            sum += i
        }
        return (min...max)
            .map { i in crabs.reduce(0, { $0 + counts[abs($1 - i)] }) }
            .min()!
    }
}
