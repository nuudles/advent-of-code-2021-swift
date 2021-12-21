//
//  Day21.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day21: Day {
    struct Die {
        var current = 0
        var count = 0

        mutating func roll() -> Int {
            defer {
                current = (current + 1) % 100
                count += 1
            }
            return current + 1
        }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        var positions = input
            .lines
            .compactMap { $0.split(separator: " ").last }
            .compactMap { Int($0) }
            .map { $0 - 1 }
        var scores = [0, 0]
        var turn = 0
        var die = Die()

        while scores.first(where: { $0 >= 1000 }) == nil {
            positions[turn] = (positions[turn] + die.roll() + die.roll() + die.roll()) % 10
            scores[turn] += positions[turn] + 1
            turn = (turn + 1) % 2
        }
        return scores.min()! * die.count
    }

    struct Universe: Hashable, Equatable {
        let positions: [Int]
        let scores: [Int]
        let turn: Int
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let positions = input
            .lines
            .compactMap { $0.split(separator: " ").last }
            .compactMap { Int($0) }
            .map { $0 - 1 }

        var wins = [0, 0]
        var universes = [
            Universe(positions: positions, scores: [0, 0], turn: 0): 1
        ]
        let rolls = product(product(1...3, 1...3), 1...3)
            .map { $0.0 + $0.1 + $1 }
            .reduce(into: Dictionary<Int, Int>()) { result, roll in
                result[roll, default: 0] += 1
            }
        while !universes.isEmpty {
            universes = universes.reduce(into: [:]) { result, pair in
                let (universe, count) = pair
                rolls.forEach { (roll, rollCount) in
                    var (positions, scores) = (universe.positions, universe.scores)
                    positions[universe.turn] = (positions[universe.turn] + roll) % 10
                    scores[universe.turn] += positions[universe.turn] + 1
                    guard scores[universe.turn] < 21 else {
                        wins[universe.turn] += count * rollCount
                        return
                    }
                    let newUniverse = Universe(positions: positions, scores: scores, turn: (universe.turn + 1) % 2)
                    result[newUniverse, default: 0] += count * rollCount
                }
            }
        }
        return wins.max() ?? 0
    }
}
