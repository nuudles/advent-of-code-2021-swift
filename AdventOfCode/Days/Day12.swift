//
//  Day12.swift
//  AdventOfCode
//

import Foundation

final class Day12: Day {
    func pathsToEnd(
        from start: String,
        seen: Set<String>,
        connections: Dictionary<String, Set<String>>,
        isPartTwo: Bool,
        canSeeTwice: String?,
        hasSeenTwice: Bool
    ) -> Set<Array<String>> {
        let canOnlyVisitOnce = start == start.lowercased()

        if start == "end" {
            return Set([["end"]])
        } else if canOnlyVisitOnce &&
                    seen.contains(start) &&
                    (canSeeTwice != start || hasSeenTwice) {
            return Set()
        }

        return connections[start, default: Set()]
            .filter { $0 != "start" }
            .reduce(into: Set<Array<String>>()) { result, connection in
                pathsToEnd(
                    from: connection,
                    seen: seen.union([start]),
                    connections: connections,
                    isPartTwo: isPartTwo,
                    canSeeTwice: canSeeTwice,
                    hasSeenTwice: hasSeenTwice || canSeeTwice == start
                ).forEach { path in
                    var newPath = path
                    newPath.append(start)
                    result.insert(newPath)
                }

                if isPartTwo && canOnlyVisitOnce && canSeeTwice == nil {
                    pathsToEnd(
                        from: connection,
                        seen: seen.union([start]),
                        connections: connections,
                        isPartTwo: isPartTwo,
                        canSeeTwice: start,
                        hasSeenTwice: false
                    ).forEach { path in
                        var newPath = path
                        newPath.append(start)
                        result.insert(newPath)
                    }
                }
            }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let connections = input
            .lines
            .reduce(into: Dictionary<String, Set<String>>()) { dictionary, line in
                let components = line.components(separatedBy: "-")
                let (left, right) = (components.first!, components.last!)
                dictionary[left] = dictionary[left, default: Set()].union([right])
                dictionary[right] = dictionary[right, default: Set()].union([left])
            }
        return pathsToEnd(
            from: "start",
            seen: Set(),
            connections: connections,
            isPartTwo: false,
            canSeeTwice: nil,
            hasSeenTwice: false
        ).count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let connections = input
            .lines
            .reduce(into: Dictionary<String, Set<String>>()) { dictionary, line in
                let components = line.components(separatedBy: "-")
                let (left, right) = (components.first!, components.last!)
                dictionary[left] = dictionary[left, default: Set()].union([right])
                dictionary[right] = dictionary[right, default: Set()].union([left])
            }
        return pathsToEnd(
            from: "start",
            seen: Set(),
            connections: connections,
            isPartTwo: true,
            canSeeTwice: nil,
            hasSeenTwice: false
        ).count
    }
}
