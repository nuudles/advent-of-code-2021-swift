//
//  Day24.swift
//  AdventOfCode
//

import Foundation

/*
 The below implementation was my initial attempts to brute force it using the run(program:) function
 and then to expand the program to see if I could get a formula for z in terms of each of the inputs.
 When that proved to not really work, I analyzed the program and solved it by hand using basically the
 same technique described here: https://github.com/mrphlip/aoc/blob/master/2021/24.md
 */

final class Day24: Day {
    func expand(program: [Substring]) {
        var v = ["w": "0", "x": "0", "y": "0", "z": "0"]
        var inputIndex = 0
        for line in program {
            print("\(line): \(v)")
            let components = line.components(separatedBy: " ")
            let a = components[1]
            let b: String? = components.count > 2 ? v[components[2], default: components[2]] : nil
            switch components[0] {
            case "inp":
                v[a] = "i[\(inputIndex)]"
                inputIndex += 1
            case "add":
                if let intA = Int(v[a]!), let intB = Int(b!) {
                    v[a] = "\(intA + intB)"
                } else if v[a]! == "0" {
                    v[a] = b!
                } else if b != "0" {
                    v[a] = "(\(v[a]!)+\(b!))"
                }
            case "mul":
                if let intA = Int(v[a]!), let intB = Int(b!) {
                    v[a] = "\(intA * intB)"
                } else if b == "0" || v[a]! == "0" {
                    v[a] = "0"
                } else if b != "1" {
                    v[a] = "(\(v[a]!)*\(b!))"
                }
            case "div":
                if let intA = Int(v[a]!), let intB = Int(b!) {
                    v[a] = "\(intA / intB)"
                } else if b != "1" {
                    v[a] = "(\(v[a]!)/\(b!))"
                }
            case "mod":
                if let intA = Int(v[a]!), let intB = Int(b!) {
                    v[a] = "\(intA % intB)"
                } else {
                    v[a] = "(\(v[a]!)%\(b!))"
                }
            case "eql":
                if let intA = Int(v[a]!), let intB = Int(b!) {
                    v[a] = "\(intA == intB ? 1 : 0)"
                } else {
                    v[a] = "(\(v[a]!)==\(b!))"
                }
            default:
                break
            }
        }
    }

    func run(program: [Substring], input: [Int]) -> [String: Int] {
        var variables = [String: Int]()
        var inputIndex = 0
        for line in program {
            let components = line.components(separatedBy: " ")
            let a = components[1]
            let b: Int? = (components.count > 2) ? variables[components[2], default: Int(components[2]) ?? 0] : nil
            switch components[0] {
            case "inp":
                variables[a] = input[inputIndex]
                inputIndex += 1
            case "add":
                variables[a, default: 0] += b ?? 0
            case "mul":
                variables[a, default: 0] *= b ?? 1
            case "div":
                variables[a] = variables[a, default: 0] / (b ?? 1)
            case "mod":
                variables[a] = variables[a, default: 0] % (b ?? 1)
            case "eql":
                variables[a] = (variables[a, default: 0] == b) ? 1 : 0
            default:
                break
            }
        }
        return variables
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let program = input.lines
        var model = Array(repeating: 9, count: 14)
        while true {
            let variables = run(program: program, input: model)
            debugPrint("\(model.map { "\($0)" }.joined()) \(variables["w"]!) \(variables["x"]!) \(variables["y"]!) \(variables["z"]!)")
            if variables["z", default: 0] == 0 {
                break
            }

            if model.allSatisfy({ $0 == 1 }) {
                break
            }

            var index = model.count - 1
            while true {
                guard index >= 0 else { break }
                model[index] -= 1
                if model[index] == 0 {
                    model[index] = 9
                    index -= 1
                    continue
                }
                break
            }
        }
        return model.map { "\($0)" }.joined()
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
}
