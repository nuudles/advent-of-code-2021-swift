//
//  Day20.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day20: Day {
    func runSteps(_ input: String, count: Int) -> Set<Position> {
        let components = input.components(separatedBy: "\n\n")
        var (xMin, xMax) = (0, 0)
        var (yMin, yMax) = (0, 0)
        let algorithm = components[0].map { "\($0)" }
        var litPixels = components[1]
            .lines
            .enumerated()
            .reduce(into: Set<Position>()) { result, pair in
                let (y, line) = pair
                line.enumerated().forEach { (x, character) in
                    guard character == "#" else { return }
                    result.insert(Position(x: x, y: y))
                    if x > xMax {
                        xMax = x
                    }
                    if y > yMax {
                        yMax = y
                    }
                }
            }
        var isOutsidePixelLit = false
        for _ in 0..<count {
            litPixels = product(yMin - 1...yMax + 1, xMin - 1...xMax + 1)
                .reduce(into: Set<Position>()) { toInsert, pair in
                    let (y, x) = pair
                    let binary = product(-1...1, -1...1).reduce(into: 0) { result, deltaPair in
                        let (dy, dx) = deltaPair
                        if (xMin...xMax).contains(x + dx) && (yMin...yMax).contains(y + dy) {
                            result = result << 1 | (litPixels.contains(Position(x: x + dx, y: y + dy)) ? 1 : 0)
                        } else {
                            result = result << 1 | (isOutsidePixelLit ? 1 : 0)
                        }
                    }
                    if algorithm[binary] == "#" {
                        toInsert.insert(Position(x: x, y: y))
                    }
                }
            xMin -= 1
            xMax += 1
            yMin -= 1
            yMax += 1
            isOutsidePixelLit = isOutsidePixelLit ? algorithm[511] == "#" : algorithm[0] == "#"
        }
        return litPixels
    }

    func part1(_ input: String) -> CustomStringConvertible {
        return runSteps(input, count: 2).count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return runSteps(input, count: 50).count
    }
}
