//
//  Day13.swift
//  AdventOfCode
//

import Foundation

final class Day13: Day {
    func fold(_ dots: Set<Position>, along fold: Position) -> Set<Position> {
        var toAdd = Set<Position>()
        var toRemove = Set<Position>()
        dots.forEach { dot in
            if fold.x < 0 && dot.y > fold.y {
                toRemove.insert(dot)
                toAdd.insert(Position(x: dot.x, y: fold.y * 2 - dot.y))
            } else if fold.y < 0 && dot.x > fold.x {
                toRemove.insert(dot)
                toAdd.insert(Position(x: fold.x * 2 - dot.x, y: dot.y))
            }
        }
        return dots.subtracting(toRemove).union(toAdd)
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let components = input.components(separatedBy: "\n\n")
        let dots = components
            .first!
            .lines
            .reduce(into: Set<Position>()) { result, line in
                let a = line.split(separator: ",")
                result.insert(Position(x: Int(a.first!) ?? 0, y: Int(a.last!) ?? 0))
            }
        let folds = components
            .last!
            .lines
            .reduce(into: Array<Position>()) { result, line in
                let a = line.split(separator: "=")
                if a.first!.contains("y") {
                    result.append(Position(x: -1, y: Int(a.last!) ?? 0))
                } else {
                    result.append(Position(x: Int(a.last!) ?? 0, y: -1))
                }
            }
        return fold(dots, along: folds.first!).count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let components = input.components(separatedBy: "\n\n")
        var dots = components
            .first!
            .lines
            .reduce(into: Set<Position>()) { result, line in
                let a = line.split(separator: ",")
                result.insert(Position(x: Int(a.first!) ?? 0, y: Int(a.last!) ?? 0))
            }
        let folds = components
            .last!
            .lines
            .reduce(into: Array<Position>()) { result, line in
                let a = line.split(separator: "=")
                if a.first!.contains("y") {
                    result.append(Position(x: -1, y: Int(a.last!) ?? 0))
                } else {
                    result.append(Position(x: Int(a.last!) ?? 0, y: -1))
                }
            }
        folds.forEach {
            dots = fold(dots, along: $0)
        }
        var display = Array(
            repeating: Array(
                repeating: " ",
                count: (dots.map({ $0.x }).max() ?? 0) + 1),
            count: (dots.map({ $0.y }).max() ?? 0) + 1
        )
        for dot in dots {
            display[dot.y][dot.x] = "O"
        }
        return "\n" +
            display
                .map { $0.joined(separator: "") }
                .joined(separator: "\n")
    }
}
