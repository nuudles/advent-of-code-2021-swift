//
//  Day19.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day19: Day {
    class Scanner: CustomDebugStringConvertible {
        let identifier: String
        var transform: Transform?
        var beacons: Set<Array<Int>>
        var deltas: Dictionary<Set<Int>, Array<Array<Int>>>
        var deltaKeys: Set<Set<Int>>

        init(string: String) {
            let lines = string.lines
            identifier = String(lines[0])
            beacons = Set(
                lines
                    .dropFirst()
                    .map { line in
                        line.split(separator: ",").compactMap { Int($0) }
                    }
            )
            deltas = product(beacons, beacons).reduce(into: [:]) { result, pair in
                guard pair.0 != pair.1 else { return }
                result[
                    Set(arrayLiteral: abs(pair.0[0] - pair.1[0]), abs(pair.0[1] - pair.1[1]), abs(pair.0[2] - pair.1[2]))
                ] = Array(arrayLiteral: pair.0, pair.1)
            }
            deltaKeys = Set(deltas.keys)
        }

        struct Transform: Hashable, Equatable {
            let rotation: [Int]
            let multiplier: [Int]
            let offset: [Int]
        }

        func lock(to scanner: Scanner) {
            func transforms(for unlocked: [[Int]], and locked: [[Int]]) -> Set<Transform> {
                let unlockedVector = [
                    unlocked[0][0] - unlocked[1][0],
                    unlocked[0][1] - unlocked[1][1],
                    unlocked[0][2] - unlocked[1][2]
                ]
                let lockedVector = [
                    locked[0][0] - locked[1][0],
                    locked[0][1] - locked[1][1],
                    locked[0][2] - locked[1][2]
                ]
                let rotation = [
                    unlockedVector.enumerated().first { abs($0.element) == abs(lockedVector[0]) }?.offset ?? 0,
                    unlockedVector.enumerated().first { abs($0.element) == abs(lockedVector[1]) }?.offset ?? 0,
                    unlockedVector.enumerated().first { abs($0.element) == abs(lockedVector[2]) }?.offset ?? 0
                ]
                var multiplier = [
                    unlockedVector[rotation[0]] > 0 ? lockedVector[0] / unlockedVector[rotation[0]] : 1,
                    unlockedVector[rotation[1]] > 0 ? lockedVector[1] / unlockedVector[rotation[1]] : 1,
                    unlockedVector[rotation[2]] > 0 ? lockedVector[2] / unlockedVector[rotation[2]] : 1
                ]
                var rotatedUnlocked = rotate(unlocked[0], with: rotation, and: multiplier)
                var offset = [
                    locked[0][0] - rotatedUnlocked[0],
                    locked[0][1] - rotatedUnlocked[1],
                    locked[0][2] - rotatedUnlocked[2]
                ]

                var transforms = Set<Transform>()
                transforms.insert(Transform(rotation: rotation, multiplier: multiplier, offset: offset))

                multiplier = [-multiplier[0], -multiplier[1], -multiplier[2]]
                rotatedUnlocked = rotate(unlocked[1], with: rotation, and: multiplier)
                offset = [
                    locked[0][0] - rotatedUnlocked[0],
                    locked[0][1] - rotatedUnlocked[1],
                    locked[0][2] - rotatedUnlocked[2]
                ]
                transforms.insert(Transform(rotation: rotation, multiplier: multiplier, offset: offset))
                return transforms
            }

            func rotate(_ position: [Int], with rotation: [Int], and multiplier: [Int]) -> [Int] {
                return [
                    position[rotation[0]] * multiplier[0],
                    position[rotation[1]] * multiplier[1],
                    position[rotation[2]] * multiplier[2]
                ]
            }

            func offset(_ position: [Int], with offset: [Int]) -> [Int] {
                return [
                    position[0] + offset[0],
                    position[1] + offset[1],
                    position[2] + offset[2]
                ]
            }

            let keys = Array(deltaKeys.intersection(scanner.deltaKeys))
            let allTransforms = keys.map {
                transforms(for: deltas[$0]!, and: scanner.deltas[$0]!)
            }
            let transform = product(allTransforms, allTransforms)
                .map { $0.intersection($1) }
                .filter { !$0.isEmpty }
                .reduce(into: Dictionary<Transform, Int>()) { counts, collection in
                    collection.forEach {
                        counts[$0, default: 0] += 1
                    }
                }
                .max { $1.value > $0.value }!
                .key

            beacons = Set(
                beacons.map { beacon in
                    offset(
                        rotate(beacon, with: transform.rotation, and: transform.multiplier),
                        with: transform.offset
                    )
                }
            )
            deltas = product(beacons, beacons).reduce(into: [:]) { result, pair in
                guard pair.0 != pair.1 else { return }
                result[
                    Set(arrayLiteral: abs(pair.0[0] - pair.1[0]), abs(pair.0[1] - pair.1[1]), abs(pair.0[2] - pair.1[2]))
                ] = Array(arrayLiteral: pair.0, pair.1)
            }

            self.transform = transform
        }

        var debugDescription: String {
            return identifier + "\n" + deltas.map { "\($0)" }.joined(separator: "\n")
        }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let scanners = input
            .components(separatedBy: "\n\n")
            .map { Scanner(string: $0) }
        var unlockedScanners = Array(scanners.dropFirst())
        var lockedScanners = Array(arrayLiteral: scanners[0])

        while unlockedScanners.count > 0 {
            let target = unlockedScanners
                .enumerated()
                .map { (index, scanner) -> (Int, Scanner, Scanner, Int) in
                    let maxLocked = lockedScanners.max { (scanner1, scanner2) in
                        scanner1.deltaKeys.intersection(scanner.deltaKeys).count < scanner2.deltaKeys.intersection(scanner.deltaKeys).count
                    }!
                    return (maxLocked.deltaKeys.intersection(scanner.deltaKeys).count, maxLocked, scanner, index)
                }
                .max { $0.0 < $1.0 }!
            let (locked, unlocked, index) = (target.1, target.2, target.3)
            unlocked.lock(to: locked)
            unlockedScanners.remove(at: index)
            lockedScanners.append(unlocked)
        }
        return lockedScanners.reduce(into: Set<Array<Int>>()) { result, scanner in
            result = result.union(scanner.beacons)
        }.count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let scanners = input
            .components(separatedBy: "\n\n")
            .map { Scanner(string: $0) }
        var unlockedScanners = Array(scanners.dropFirst())
        var lockedScanners = Array(arrayLiteral: scanners[0])

        while unlockedScanners.count > 0 {
            let target = unlockedScanners
                .enumerated()
                .map { (index, scanner) -> (Int, Scanner, Scanner, Int) in
                    let maxLocked = lockedScanners.max { (scanner1, scanner2) in
                        scanner1.deltaKeys.intersection(scanner.deltaKeys).count < scanner2.deltaKeys.intersection(scanner.deltaKeys).count
                    }!
                    return (maxLocked.deltaKeys.intersection(scanner.deltaKeys).count, maxLocked, scanner, index)
                }
                .max { $0.0 < $1.0 }!
            let (locked, unlocked, index) = (target.1, target.2, target.3)
            unlocked.lock(to: locked)
            unlockedScanners.remove(at: index)
            lockedScanners.append(unlocked)
        }

        return product(lockedScanners, lockedScanners).compactMap { s1, s2 -> Int? in
            guard s1 !== s2 else { return nil }
            let o1 = s1.transform?.offset ?? [0, 0, 0]
            let o2 = s2.transform?.offset ?? [0, 0, 0]
            return abs(o1[0] - o2[0]) + abs(o1[1] - o2[1]) + abs(o1[2] - o2[2])
        }.max() ?? 0
    }
}
