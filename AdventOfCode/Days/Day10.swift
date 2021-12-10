//
//  Day10.swift
//  AdventOfCode
//

import Foundation

final class Day10: Day {
    let matches: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">"]

    func part1(_ input: String) -> CustomStringConvertible {
        let scores: [Character: Int] = [")": 3, "]": 57, "}": 1197, ">": 25137]
        return input
            .lines
            .map { line -> Int in
                var stack = [Character]()
                for character in line {
                    if let match = matches[character] {
                        stack.append(match)
                    } else if stack.last == character {
                        stack.removeLast()
                    } else {
                        return scores[character, default: 0]
                    }
                }
                return 0
            }
            .sum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let values: [Character: Int] = [")": 1, "]": 2, "}": 3, ">": 4]
        let scores = input
            .lines
            .map { line in
                var stack = [Character]()
                for character in line {
                    if let match = matches[character] {
                        stack.append(match)
                    } else if stack.last == character {
                        stack.removeLast()
                    } else {
                        return 0
                    }
                }

                return stack.reversed().reduce(0) { score, character in
                    score * 5 + values[character, default: 0]
                }
            }
            .filter { $0 != 0 }
            .sorted()
        return scores[scores.count / 2]
    }
}
