//
//  Day11.swift
//  AdventOfCode
//

import Foundation

final class Day11: Day {
    struct Position: Hashable, Equatable {
        let x: Int
        let y: Int
    }

    func step(_ octopi: [[Int]]) -> (Int, [[Int]]) {
        var flashPositions = Set<Position>()
        var newOctopi = octopi.enumerated().map { line in
            line.element.enumerated().map { (index, energy) -> Int in
                if energy >= 9 {
                    flashPositions.insert(Position(x: index, y: line.offset))
                }
                return energy + 1
            }
        }
        var newFlashes = flashPositions
        while newFlashes.count > 0 {
            var nextFlashes = Set<Position>()
            newFlashes.forEach { flash in
                for j in max(0, flash.y - 1)...min(newOctopi.count - 1, flash.y + 1) {
                    for i in max(0, flash.x - 1)...min(newOctopi[j].count - 1, flash.x + 1) {
                        let position = Position(x: i, y: j)
                        guard position != flash else { continue }
                        newOctopi[j][i] += 1
                        if newOctopi[j][i] > 9 && !flashPositions.contains(position) {
                            flashPositions.insert(position)
                            nextFlashes.insert(position)
                        }
                    }
                }
            }
            newFlashes = nextFlashes
        }
        flashPositions.forEach {
            newOctopi[$0.y][$0.x] = 0
        }
        return (flashPositions.count, newOctopi)
    }

    func part1(_ input: String) -> CustomStringConvertible {
        var octopi = input.lines.map { line in line.compactMap { $0.wholeNumberValue } }
        var flashes = 0
        for _ in 0..<100 {
            let (newFlashes, newOctopi) = step(octopi)
            flashes += newFlashes
            octopi = newOctopi
        }
        return flashes
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var octopi = input.lines.map { line in line.compactMap { $0.wholeNumberValue } }
        var steps = 0
        while octopi.map({ $0.sum }).sum != 0 {
            let (_, newOctopi) = step(octopi)
            steps += 1
            octopi = newOctopi
        }
        return steps
    }
}
