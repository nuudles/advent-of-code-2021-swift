//
//  Day22.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day22: Day {
    struct Cuboid: Hashable, Equatable {
        let xRange: Range<Int>
        let yRange: Range<Int>
        let zRange: Range<Int>

        var volume: Int {
            return xRange.count * yRange.count * zRange.count
        }

        func overlaps(_ cuboid: Cuboid) -> Bool {
            return xRange.overlaps(cuboid.xRange) && yRange.overlaps(cuboid.yRange) && zRange.overlaps(cuboid.zRange)
        }

        func intersection(_ cuboid: Cuboid) -> Cuboid {
            return Cuboid(
                xRange: max(xRange.lowerBound, cuboid.xRange.lowerBound)..<min(xRange.upperBound, cuboid.xRange.upperBound),
                yRange: max(yRange.lowerBound, cuboid.yRange.lowerBound)..<min(yRange.upperBound, cuboid.yRange.upperBound),
                zRange: max(zRange.lowerBound, cuboid.zRange.lowerBound)..<min(zRange.upperBound, cuboid.zRange.upperBound)
            )
        }

        func removing(_ cuboid: Cuboid) -> Set<Cuboid> {
            guard !cuboid.xRange.isEmpty && !cuboid.yRange.isEmpty && !cuboid.zRange.isEmpty else { return Set(arrayLiteral: self) }
            let intersecting = intersection(cuboid)
            return Set(
                arrayLiteral: Cuboid(
                    xRange: xRange.lowerBound..<intersecting.xRange.lowerBound,
                    yRange: yRange,
                    zRange: zRange
                ),
                Cuboid(
                    xRange: intersecting.xRange.upperBound..<xRange.upperBound,
                    yRange: yRange,
                    zRange: zRange
                ),
                Cuboid(
                    xRange: intersecting.xRange,
                    yRange: yRange.lowerBound..<intersecting.yRange.lowerBound,
                    zRange: zRange
                ),
                Cuboid(
                    xRange: intersecting.xRange,
                    yRange: intersecting.yRange.upperBound..<yRange.upperBound,
                    zRange: zRange
                ),
                Cuboid(
                    xRange: intersecting.xRange,
                    yRange: intersecting.yRange,
                    zRange: zRange.lowerBound..<intersecting.zRange.lowerBound
                ),
                Cuboid(
                    xRange: intersecting.xRange,
                    yRange: intersecting.yRange,
                    zRange: intersecting.zRange.upperBound..<zRange.upperBound
                )
            ).filter { !$0.xRange.isEmpty && !$0.yRange.isEmpty && !$0.zRange.isEmpty }
        }
    }

    func part1(_ input: String) -> CustomStringConvertible {
        let litCubes = input
            .lines
            .reduce(into: Set<Cuboid>()) { result, line in
                let groups = String(line).groups(for: #"(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)"#)
                let isOn = groups[0][1] == "on"
                let xRange = (Int(groups[0][2])!..<Int(groups[0][3])! + 1).clamped(to: -50..<51)
                let yRange = (Int(groups[0][4])!..<Int(groups[0][5])! + 1).clamped(to: -50..<51)
                let zRange = (Int(groups[0][6])!..<Int(groups[0][7])! + 1).clamped(to: -50..<51)

                let cuboid = Cuboid(xRange: xRange, yRange: yRange, zRange: zRange)
                for overlap in result.filter({ $0.overlaps(cuboid) }) {
                    result.remove(overlap)
                    result = result.union(overlap.removing(cuboid))
                }
                if isOn {
                    result.insert(cuboid)
                }
            }
        return litCubes
            .map { $0.volume }
            .sum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let litCubes = input
            .lines
            .reduce(into: Set<Cuboid>()) { result, line in
                let groups = String(line).groups(for: #"(on|off) x=(-?\d+)..(-?\d+),y=(-?\d+)..(-?\d+),z=(-?\d+)..(-?\d+)"#)
                let isOn = groups[0][1] == "on"
                let xRange = Int(groups[0][2])!..<Int(groups[0][3])! + 1
                let yRange = Int(groups[0][4])!..<Int(groups[0][5])! + 1
                let zRange = Int(groups[0][6])!..<Int(groups[0][7])! + 1

                let cuboid = Cuboid(xRange: xRange, yRange: yRange, zRange: zRange)
                for overlap in result.filter({ $0.overlaps(cuboid) }) {
                    result.remove(overlap)
                    result = result.union(overlap.removing(cuboid))
                }
                if isOn {
                    result.insert(cuboid)
                }
            }
        return litCubes
            .map { $0.volume }
            .sum
    }
}
