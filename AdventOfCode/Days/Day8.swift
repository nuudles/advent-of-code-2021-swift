//
//  Day8.swift
//  AdventOfCode
//

import Foundation

final class Day8: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        return input
            .lines
            .flatMap { line in line.split(separator: "|").last!.split(separator: " ") }
            .count { [2, 3, 4, 7].contains($0.count) }
    }

    func digitMapping(digits: [String]) -> [Set<String.UnicodeScalarView.Element>: Decimal] {
        let characters = digits.map { Set($0.unicodeScalars) }
        var mapping = Array(repeating: Set<String.UnicodeScalarView.Element>(), count: 10)
        mapping[1] = characters.filter { $0.count == 2 }.first ?? Set()
        mapping[7] = characters.filter { $0.count == 3 }.first ?? Set()
        mapping[4] = characters.filter { $0.count == 4 }.first ?? Set()
        mapping[8] = characters.filter { $0.count == 7 }.first ?? Set()
        let right = mapping[1]
        let top = mapping[7].subtracting(right)

        mapping[6] = characters
            .filter { $0.count == 6 && !$0.isSuperset(of: right) }
            .first ?? Set()
        let bottomRight = mapping[6].intersection(right)
        let topRight = right.subtracting(bottomRight)

        let almostNine = mapping[4].union(mapping[7])
        mapping[9] = characters
            .filter { $0.count == 6 && $0.isSuperset(of: almostNine) }
            .first ?? Set()
        let bottomLeft = mapping[8].subtracting(mapping[9])
        let bottom = mapping[9].subtracting(almostNine)

        mapping[5] = characters
            .filter { $0 == mapping[6].subtracting(bottomLeft) }
            .first ?? Set()
        mapping[2] = characters
            .filter { $0.count == 5 && !$0.isSuperset(of: right) && $0 != mapping[5] }
            .first ?? Set()
        let middle = mapping[2].subtracting(topRight).subtracting(bottomLeft).subtracting(top).subtracting(bottom)
        mapping[0] = characters
            .filter { $0 == mapping[8].subtracting(middle) }
            .first ?? Set()
        mapping[3] = characters
            .filter { $0 == right.union(top).union(middle).union(bottom) }
            .first ?? Set()
        return mapping
            .enumerated()
            .reduce(into: [:]) { $0[$1.element] = Decimal($1.offset) }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return input
            .lines
            .map { line -> Decimal in
                let components = line.split(separator: "|")
                let mapping = digitMapping(digits: components.first!.split(separator: " ").map(String.init))
                return components
                    .last!
                    .split(separator: " ")
                    .reversed()
                    .enumerated()
                    .reduce(0) { result, component in
                        let multiplier = pow(10, component.offset)
                        return result + mapping[Set(component.element.unicodeScalars), default: 0] * multiplier
                    }
            }
            .sum
    }
}
