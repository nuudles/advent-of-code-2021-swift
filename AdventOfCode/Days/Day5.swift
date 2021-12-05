//
//  Day5.swift
//  AdventOfCode
//

import Foundation

final class Day5: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        var intersections = [String: Int]()
        input
            .lines
            .forEach { line in
                let components = line
                    .components(separatedBy: " -> ")
                    .map { component -> (Int, Int) in
                        let nums = component
                            .split(separator: ",")
                            .compactMap { Int($0) }
                        return (nums.first!, nums.last!)
                    }
                let (start, end) = (components[0], components[1])
                if start.0 == end.0 {
                    for y in min(start.1, end.1)...max(start.1, end.1) {
                        let key = "\(start.0),\(y)"
                        intersections[key] = (intersections[key] ?? 0) + 1
                    }
                } else if start.1 == end.1 {
                    for x in min(start.0, end.0)...max(start.0, end.0) {
                        let key = "\(x),\(start.1)"
                        intersections[key] = (intersections[key] ?? 0) + 1
                    }
                }
            }
        return intersections.count { $0.value > 1 }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var intersections = [String: Int]()
        input
            .lines
            .forEach { line in
                let components = line
                    .components(separatedBy: " -> ")
                    .map { component -> (Int, Int) in
                        let nums = component
                            .split(separator: ",")
                            .compactMap { Int($0) }
                        return (nums.first!, nums.last!)
                    }
                let (start, end) = (components[0], components[1])
                let (dx, dy) = (
                    start.0 == end.0 ? 0 : start.0 < end.0 ? 1 : -1,
                    start.1 == end.1 ? 0 : start.1 < end.1 ? 1 : -1
                )
                var point = start
                while point != end {
                    let key = "\(point.0),\(point.1)"
                    intersections[key] = (intersections[key] ?? 0) + 1
                    point.0 += dx
                    point.1 += dy
                }

                let key = "\(point.0),\(point.1)"
                intersections[key] = (intersections[key] ?? 0) + 1
            }
        return intersections.count { $0.value > 1 }
    }
}
