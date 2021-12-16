//
//  Day16.swift
//  AdventOfCode
//

import Foundation

final class Day16: Day {
    enum Packet {
        case literal(version: Int, value: Int)
        case operation(version: Int, typeId: Int, subpackets: [Packet])

        init(binary: Substring, index: inout Int) {
            let version = Int(binary[index..<index + 2], radix: 2) ?? 0
            index += 3
            let packetTypeId = Int(binary[index..<index + 2], radix: 2) ?? 0
            index += 3
            if packetTypeId == 4 {
                var valueBinary = ""
                while true {
                    valueBinary.append(contentsOf: binary[index + 1..<index + 4])
                    index += 5
                    if binary[index - 5] == "0" {
                        break
                    }
                }

                self = .literal(version: version, value: Int(valueBinary, radix: 2) ?? 0)
            } else {
                var subpackets = [Packet]()

                let lengthTypeId = binary[index]
                index += 1

                if lengthTypeId == "0" {
                    let length = Int(binary[index..<index + 14], radix: 2) ?? 0
                    index += 15
                    let maxIndex = length + index
                    while index < maxIndex {
                        subpackets.append(Packet(binary: binary, index: &index))
                    }
                } else {
                    let count = Int(binary[index..<index + 10], radix: 2) ?? 0
                    index += 11
                    for _ in 0..<count {
                        subpackets.append(Packet(binary: binary, index: &index))
                    }
                }
                self = .operation(version: version, typeId: packetTypeId, subpackets: subpackets)
            }
        }

        var versionSum: Int {
            switch self {
            case .literal(version: let version, value: _):
                return version
            case .operation(version: let version, typeId: _, subpackets: let subpackets):
                return version + subpackets.map { $0.versionSum }.sum
            }
        }

        var value: Int {
            switch self {
            case .literal(version: _, value: let value):
                return value
            case .operation(version: _, typeId: let typeId, subpackets: let subpackets):
                switch typeId {
                case 0:
                    return subpackets.map { $0.value }.sum
                case 1:
                    return subpackets.map { $0.value }.product
                case 2:
                    return subpackets.map { $0.value }.min() ?? 0
                case 3:
                    return subpackets.map { $0.value }.max() ?? 0
                case 5:
                    return subpackets[0].value > subpackets[1].value ? 1 : 0
                case 6:
                    return subpackets[0].value < subpackets[1].value ? 1 : 0
                case 7:
                    return subpackets[0].value == subpackets[1].value ? 1 : 0
                default:
                    return 0
                }
            }
        }
    }

    let hexMapping: [Character: String] = [
        "0": "0000",
        "1": "0001",
        "2": "0010",
        "3": "0011",
        "4": "0100",
        "5": "0101",
        "6": "0110",
        "7": "0111",
        "8": "1000",
        "9": "1001",
        "A": "1010",
        "B": "1011",
        "C": "1100",
        "D": "1101",
        "E": "1110",
        "F": "1111"
    ]

    func part1(_ input: String) -> CustomStringConvertible {
        let binary = input
            .map { hexMapping[$0, default: ""] }
            .joined(separator: "")
        var index = 0
        let packet = Packet(binary: binary.dropFirst(0), index: &index)
        return packet.versionSum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let binary = input
            .map { hexMapping[$0, default: ""] }
            .joined(separator: "")
        var index = 0
        let packet = Packet(binary: binary.dropFirst(0), index: &index)
        return packet.value
    }
}
