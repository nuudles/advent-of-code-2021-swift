//
//  Day23.swift
//  AdventOfCode
//

import Foundation

final class Day23: Day {
    static let energyRequirement = ["A": 1, "B": 10, "C": 100, "D": 1000]
    static let homes = ["A": 0, "B": 1, "C": 2, "D": 3]
    static let entrances = [2, 4, 6, 8]

    struct State: Hashable, Equatable {
        let burrows: [[String]]
        let hallway: [String]

        var isComplete: Bool {
            return burrows.enumerated().allSatisfy { burrow in
                burrow.element.allSatisfy { homes[$0] == burrow.offset }
            }
        }

        func nextMoves(score: Int) -> [State: Int] {
            guard !isComplete else { return [:] }
            var moves = [State: Int]()
            burrows
                .enumerated()
                .filter { burrow in !burrow.element.allSatisfy({ Day23.homes[$0] == burrow.offset }) }
                .compactMap { burrow -> (Int, EnumeratedSequence<[String]>.Element)? in
                    guard let first = burrow.element.enumerated().first(where: { $0.element != "" })
                    else { return nil }
                    return (burrow.offset, first)
                }
                .forEach { (entrance, amphipod) in
                    var burrows = self.burrows
                    burrows[entrance][amphipod.offset] = ""
                    let entranceOffset = Day23.entrances[entrance]
                    for i in (0..<entranceOffset).reversed() {
                        if hallway[i] != "" {
                            break
                        }
                        if Day23.entrances.contains(i) {
                            continue
                        }
                        var hallway = self.hallway
                        hallway[i] = amphipod.element
                        let newState = State(burrows: burrows, hallway: hallway)
                        moves[newState] = (amphipod.offset + 1 + entranceOffset - i) * Day23.energyRequirement[amphipod.element, default: 0] + score
                    }
                    for i in (entranceOffset + 1)..<11 {
                        if hallway[i] != "" {
                            break
                        }
                        if Day23.entrances.contains(i) {
                            continue
                        }
                        var hallway = self.hallway
                        hallway[i] = amphipod.element
                        let newState = State(burrows: burrows, hallway: hallway)
                        moves[newState] = (amphipod.offset + 1 + i - entranceOffset) * Day23.energyRequirement[amphipod.element, default: 0] + score
                    }
                }
            hallway
                .enumerated()
                .filter { $0.element != "" }
                .forEach { amphipod in
                    let home = Day23.homes[amphipod.element, default: 0]
                    let entrance = Day23.entrances[home]
                    var burrows = self.burrows
                    guard burrows[home].allSatisfy({ $0 == amphipod.element || $0 == "" }) else { return }
                    var hallway = self.hallway
                    for i in (amphipod.offset < entrance ? (amphipod.offset + 1)..<entrance : entrance..<amphipod.offset) {
                        if hallway[i] != "" {
                            return
                        }
                    }
                    hallway[amphipod.offset] = ""
                    var steps = abs(amphipod.offset - Day23.entrances[home])
                    for (i, c) in burrows[home].enumerated().reversed() {
                        guard c == "" else { continue }
                        burrows[home][i] = amphipod.element
                        steps += i + 1
                        break
                    }
                    let newState = State(burrows: burrows, hallway: hallway)
                    moves[newState] = steps * Day23.energyRequirement[amphipod.element, default: 0] + score
                }
            return moves
        }
    }

    func minEnergyRequired(burrows: [[String]]) -> Int {
        var states = [
            State(
                burrows: burrows,
                hallway: Array(repeating: "", count: 11)
            ): 0
        ]

        var seen = Set<State>()
        while !states.keys.allSatisfy({ $0.isComplete || seen.contains($0) }) {
            for (state, score) in states.filter({ !$0.key.isComplete && !seen.contains($0.key) }) {
                state.nextMoves(score: score).forEach { (newState, score) in
                    if score < states[newState, default: Int.max] {
                        states[newState] = score
                        if !newState.isComplete {
                            seen.remove(newState)
                        }
                    }
                }
                seen.insert(state)
            }
        }

        return states
            .filter { $0.key.isComplete }
            .map { $0.value }
            .min() ?? 0
    }

    func part1(_ input: String) -> CustomStringConvertible {
        return minEnergyRequired(burrows: [
            ["B", "A"],
            ["C", "D"],
            ["B", "C"],
            ["D", "A"]
        ])
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return minEnergyRequired(burrows: [
            ["B", "D", "D", "A"],
            ["C", "C", "B", "D"],
            ["B", "B", "A", "C"],
            ["D", "A", "C", "A"]
        ])
    }
}
