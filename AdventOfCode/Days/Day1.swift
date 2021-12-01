//
//  Day1.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day1: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        return input
            .split(separator: "\n")
            .compactMap { Int($0) }
            .adjacentPairs()
            .count { $0 < $1 }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return input
            .split(separator: "\n")
            .compactMap { Int($0) }
            .windows(ofCount: 3)
            .adjacentPairs()
            .count {
                $0.sum < $1.sum
            }
    }
}
