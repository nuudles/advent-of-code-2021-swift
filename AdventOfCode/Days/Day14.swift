//
//  Day14.swift
//  AdventOfCode
//

import Foundation

final class Day14: Day {
    private func runSteps(input: String, count: Int) -> Int {
        let components = input.components(separatedBy: "\n\n")
        let template = components.first!
        let rules = components
            .last!
            .lines
            .reduce(into: [[Character]: Character]()) { result, line in
                result[[line[line.startIndex], line[line.index(after: line.startIndex)]]] = line.last!
            }
        var charCounts = template
            .reduce(into: [Character: Int]()) { result, character in
                result[character] = result[character, default: 0] + 1
            }
        var polymerCounts = template
            .adjacentPairs()
            .reduce(into: [[Character]: Int]()) { result, pair in
                result[[pair.0, pair.1]] = result[[pair.0, pair.1], default: 0] + 1
            }
        for _ in 0..<count {
            polymerCounts = polymerCounts.reduce(into: [:]) { result, pair in
                let (key, value) = pair
                guard let newCharacter = rules[[key[0], key[1]]] else { return }
                charCounts[newCharacter] = charCounts[newCharacter, default: 0] + value
                result[[key[0], newCharacter]] = result[[key[0], newCharacter], default: 0] + value
                result[[newCharacter, key[1]]] = result[[newCharacter, key[1]], default: 0] + value
            }
        }
        return charCounts.values.max()! - charCounts.values.min()!
    }

    func part1(_ input: String) -> CustomStringConvertible {
        return runSteps(input: input, count: 10)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return runSteps(input: input, count: 40)
    }
}
