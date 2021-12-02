//
//  Day2.swift
//  AdventOfCode
//

import Foundation

final class Day2: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        var x = 0
        var y = 0
        input
            .split(separator: "\n")
            .forEach { line in
                let command = line.components(separatedBy: " ")
                switch command[0] {
                case "forward":
                    x += Int(command[1]) ?? 0
                case "down":
                    y += Int(command[1]) ?? 0
                case "up":
                    y -= Int(command[1]) ?? 0
                default:
                    break
                }
            }
        return x * y
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var x = 0
        var y = 0
        var aim = 0
        input
            .split(separator: "\n")
            .forEach { line in
                let command = line.components(separatedBy: " ")
                switch command[0] {
                case "forward":
                    x += Int(command[1]) ?? 0
                    y += (Int(command[1]) ?? 0) * aim
                case "down":
                    aim += Int(command[1]) ?? 0
                case "up":
                    aim -= Int(command[1]) ?? 0
                default:
                    break
                }
            }
        return x * y
    }
}
