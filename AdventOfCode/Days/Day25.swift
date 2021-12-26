//
//  Day25.swift
//  AdventOfCode
//

import Foundation

final class Day25: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let rows = input.lines
        let yMax = rows.count
        let xMax = rows[0].count
        var eastFacing = Set<Position>()
        var southFacing = Set<Position>()
        rows.enumerated().forEach { y, line in
            line.enumerated().forEach { x, c in
                if c == ">" {
                    eastFacing.insert(Position(x: x, y: y))
                } else if c == "v" {
                    southFacing.insert(Position(x: x, y: y))
                }
            }
        }
        var steps = 0
        while true {
            let eastMoving = eastFacing.compactMap { position -> (Position, Position)? in
                let newPosition = Position(x: (position.x + 1) % xMax, y: position.y)
                guard !eastFacing.contains(newPosition) && !southFacing.contains(newPosition)
                else { return nil }
                return (position, newPosition)
            }
            eastFacing = eastFacing.subtracting(eastMoving.map { $0.0 }).union(eastMoving.map { $0.1 })
            let southMoving = southFacing.compactMap { position -> (Position, Position)? in
                let newPosition = Position(x: position.x, y: (position.y + 1) % yMax)
                guard !eastFacing.contains(newPosition) && !southFacing.contains(newPosition)
                else { return nil }
                return (position, newPosition)
            }
            southFacing = southFacing.subtracting(southMoving.map { $0.0 }).union(southMoving.map { $0.1 })
            steps += 1
            if eastMoving.isEmpty && southMoving.isEmpty {
                break
            }
        }
        return steps
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
}
