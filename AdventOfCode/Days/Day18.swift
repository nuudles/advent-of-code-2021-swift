//
//  Day18.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day18: Day {
    class SnailfishNumber: CustomDebugStringConvertible {
        var left: SnailfishNumber?
        var right: SnailfishNumber?
        var literal: Int?
        weak var parent: SnailfishNumber?
        var depth: Int

        init(left: SnailfishNumber, right: SnailfishNumber) {
            self.left = left
            self.right = right
            parent = nil
            literal = nil
            depth = 0
        }

        init(literal: Int, parent: SnailfishNumber, depth: Int) {
            self.literal = literal
            left = nil
            right = nil
            self.parent = parent
            self.depth = depth
        }

        init(string: Substring, parent: SnailfishNumber?, depth: Int, index: inout Int) {
            left = nil
            right = nil
            literal = nil
            self.parent = parent
            self.depth = depth

            if string[index] == "[" {
                index += 1
                left = SnailfishNumber(
                    string: string,
                    parent: self,
                    depth: depth + 1,
                    index: &index
                )
                // Next should be a ","
                index += 1
                right = SnailfishNumber(
                    string: string,
                    parent: self,
                    depth: depth + 1,
                    index: &index
                )
                // Next should be a "]"
                index += 1
            } else {
                literal = string[index].wholeNumberValue
                index += 1
            }
        }

        func adding(_ other: SnailfishNumber) -> SnailfishNumber {
            let result = SnailfishNumber(left: self, right: other)
            parent = result
            other.parent = result
            incrementDepth()
            other.incrementDepth()
            result.reduce()
            return result
        }

        func reduce() {
            while true {
                if explode() {
                    continue
                }
                if split() {
                    continue
                }
                break
            }
        }

        func explode() -> Bool {
            guard literal == nil else { return false }
            if depth >= 4,
               let leftLiteral = left?.literal,
               let rightLiteral = right?.literal {
                if let nextLeft = nextLeftLiteral() {
                    nextLeft.literal = (nextLeft.literal ?? 0) + leftLiteral
                }
                if let nextRight = nextRightLiteral() {
                    nextRight.literal = (nextRight.literal ?? 0) + rightLiteral
                }
                literal = 0
                left = nil
                right = nil
                return true
            } else {
                return left!.explode() || right!.explode()
            }
        }

        func split() -> Bool {
            guard let literal = literal else {
                return left!.split() || right!.split()
            }
            guard literal > 9 else { return false }

            self.literal = nil
            left = SnailfishNumber(
                literal: Int(floor(Double(literal) / 2.0)),
                parent: self,
                depth: depth + 1
            )
            right = SnailfishNumber(
                literal: Int(ceil(Double(literal) / 2.0)),
                parent: self,
                depth: depth + 1
            )
            return true
        }

        func nextLeftLiteral() -> SnailfishNumber? {
            var current: SnailfishNumber?
            if parent?.left === self {
                current = parent
                while current != nil && current?.parent?.left === current {
                    current = current?.parent
                }
                current = current?.parent?.left
            } else {
                current = parent?.left
            }
            while current != nil && current?.literal == nil {
                current = current?.right
            }
            return current
        }

        func nextRightLiteral() -> SnailfishNumber? {
            var current: SnailfishNumber?
            if parent?.right === self {
                current = parent
                while current != nil && current?.parent?.right === current {
                    current = current?.parent
                }
                current = current?.parent?.right
            } else {
                current = parent?.right
            }
            while current != nil && current?.literal == nil {
                current = current?.left
            }
            return current
        }

        func incrementDepth() {
            depth += 1
            left?.incrementDepth()
            right?.incrementDepth()
        }

        var magnitude: Int {
            if let literal = literal {
                return literal
            }
            return left!.magnitude * 3 + right!.magnitude * 2
        }

        var debugDescription: String {
            if let literal = literal {
                return "\(literal)"
            } else {
                return "[\(left!),\(right!)]"
            }
        }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let numbers = input.lines.map { line -> SnailfishNumber in
            var index = 0
            return SnailfishNumber(string: line.dropFirst(0), parent: nil, depth: 0, index: &index)
        }

        return numbers
            .dropFirst()
            .reduce(numbers[0]) { $0.adding($1) }
            .magnitude
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let lines = input.lines

        return product(0..<lines.count, 0..<lines.count)
            .compactMap { (i1, i2) -> Int? in
                guard i1 != i2 else { return nil }
                var index1 = 0
                var index2 = 0
                let s1 = SnailfishNumber(string: lines[i1], parent: nil, depth: 0, index: &index1)
                let s2 = SnailfishNumber(string: lines[i2], parent: nil, depth: 0, index: &index2)
                return s1.adding(s2).magnitude
            }
            .max() ?? 0
    }
}
