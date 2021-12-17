//
//  Day17.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day17: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let groups = input.groups(for: #"target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)"#)
            .flatMap { group in group.compactMap { Int($0) } }
        let xRange = min(groups[0], groups[1])...max(groups[0], groups[1])
        let yRange = min(groups[2], groups[3])...max(groups[2], groups[3])

        return product(1...xRange.upperBound, 1...200).compactMap { (x, y) -> Int? in
            var velocity = (x, y)
            var position = (0, 0)
            var localMaxY = Int.min

            while true {
                position.0 += velocity.0
                position.1 += velocity.1
                velocity.0 = max(velocity.0 - 1, 0)
                velocity.1 -= 1

                if position.1 > localMaxY {
                    localMaxY = position.1
                }

                if xRange.contains(position.0) && yRange.contains(position.1) {
                    return localMaxY
                } else if position.0 < xRange.lowerBound && velocity.0 == 0 || position.1 < yRange.lowerBound {
                    return nil
                }
            }
        }.max() ?? 0
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let groups = input.groups(for: #"target area: x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)"#)
            .flatMap { group in group.compactMap { Int($0) } }
        let xRange = min(groups[0], groups[1])...max(groups[0], groups[1])
        let yRange = min(groups[2], groups[3])...max(groups[2], groups[3])

        return product(1...xRange.upperBound, -300...300).count { (x, y) in
            var velocity = (x, y)
            var position = (0, 0)
            var localMaxY = Int.min

            while true {
                position.0 += velocity.0
                position.1 += velocity.1
                velocity.0 = max(velocity.0 - 1, 0)
                velocity.1 -= 1

                if position.1 > localMaxY {
                    localMaxY = position.1
                }

                if xRange.contains(position.0) && yRange.contains(position.1) {
                    return true
                } else if position.0 < xRange.lowerBound && velocity.0 == 0 || position.1 < yRange.lowerBound {
                    return false
                }
            }
        }
    }
}
