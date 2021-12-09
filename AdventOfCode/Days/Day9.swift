//
//  Day9.swift
//  AdventOfCode
//

import Foundation

final class Day9: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let field = input.lines.map { line in line.compactMap { Int(String($0)) } }
        return field
            .enumerated()
            .map { row in
                row
                    .element
                    .enumerated()
                    .filter { (index, value) in
                        let horizontal =
                            value < (field[safe: row.offset]?[safe: index - 1] ?? Int.max) &&
                            value < (field[safe: row.offset]?[safe: index + 1] ?? Int.max)
                        let vertical =
                            value < (field[safe: row.offset - 1]?[safe: index] ?? Int.max) &&
                            value < (field[safe: row.offset + 1]?[safe: index] ?? Int.max)
                        return horizontal && vertical
                    }
                    .map { $0.element + 1 }
                    .sum
            }
            .sum
    }

    func basinSize(field: [[Int]], coordinate: (Int, Int), size: Int, checked: inout [[Bool]]) -> Int {
        guard (field[safe: coordinate.0]?[safe: coordinate.1] ?? 9) != 9,
              !(checked[safe: coordinate.0]?[safe: coordinate.1] ?? true)
        else { return size }
        checked[coordinate.0][coordinate.1] = true
        return size + 1 +
            basinSize(field: field, coordinate: (coordinate.0 - 1, coordinate.1), size: size, checked: &checked) +
            basinSize(field: field, coordinate: (coordinate.0 + 1, coordinate.1), size: size, checked: &checked) +
            basinSize(field: field, coordinate: (coordinate.0, coordinate.1 - 1), size: size, checked: &checked) +
            basinSize(field: field, coordinate: (coordinate.0, coordinate.1 + 1), size: size, checked: &checked)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let field = input.lines.map { line in line.compactMap { Int(String($0)) } }
        var checked = field.map { Array(repeating: false, count: $0.count) }
        return field
            .enumerated()
            .flatMap { row in
                row
                    .element
                    .enumerated()
                    .filter { (index, value) in
                        let horizontal =
                            value < (field[safe: row.offset]?[safe: index - 1] ?? Int.max) &&
                            value < (field[safe: row.offset]?[safe: index + 1] ?? Int.max)
                        let vertical =
                            value < (field[safe: row.offset - 1]?[safe: index] ?? Int.max) &&
                            value < (field[safe: row.offset + 1]?[safe: index] ?? Int.max)
                        return horizontal && vertical
                    }
                    .map {
                        basinSize(
                            field: field,
                            coordinate: (row.offset, $0.offset),
                            size: 0,
                            checked: &checked
                        )
                    }
            }
            .sorted()
            .reversed()[0..<3]
            .product
    }
}
