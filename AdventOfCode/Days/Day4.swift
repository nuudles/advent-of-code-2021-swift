//
//  Day4.swift
//  AdventOfCode
//

import Foundation

final class Day4: Day {
    class Board {
        let numbers: [[Int]]
        var potentialWinners: [[Int]]

        init(_ string: String) {
            numbers = string
                .split(separator: "\n")
                .map { line in
                    line
                        .split(separator: " ")
                        .compactMap { Int($0) }
                }
            var potentialWinners = numbers
            for i in 0..<5 {
                potentialWinners.append(
                    [
                        numbers[0][i],
                        numbers[1][i],
                        numbers[2][i],
                        numbers[3][i],
                        numbers[4][i]
                    ]
                )
            }
            self.potentialWinners = potentialWinners
        }

        func mark(_ number: Int) -> Bool {
            potentialWinners = potentialWinners.map { row in row.filter { $0 != number } }
            return potentialWinners.contains { $0.count == 0 }
        }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let components = input.components(separatedBy: "\n\n")
        let numbers = components.first!.split(separator: ",").compactMap { Int($0) }
        let boards = components.dropFirst().map { Board($0) }
        for number in numbers {
            for board in boards {
                if board.mark(number) {
                    return board
                        .potentialWinners
                        .reduce(Set<Int>()) { s, r in
                            var set = s
                            for n in r {
                                set.insert(n)
                            }
                            return set
                        }
                        .sum * number
                }
            }
        }
        return 0
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let components = input.components(separatedBy: "\n\n")
        let numbers = components.first!.split(separator: ",").compactMap { Int($0) }
        var boards = components.dropFirst().map { Board($0) }
        for number in numbers {
            for (i, board) in boards.enumerated().reversed() {
                if board.mark(number) {
                    if boards.count == 1 {
                        return board
                            .potentialWinners
                            .reduce(Set<Int>()) { s, r in
                                var set = s
                                for n in r {
                                    set.insert(n)
                                }
                                return set
                            }
                            .sum * number
                    } else {
                        boards.remove(at: i)
                    }
                }
            }
        }
        return 0
    }
}
