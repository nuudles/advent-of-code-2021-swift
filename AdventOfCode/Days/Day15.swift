//
//  Day15.swift
//  AdventOfCode
//

import Algorithms
import Foundation

final class Day15: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let risks = input.lines.map { line in line.compactMap { $0.wholeNumberValue } }
        let vertices = risks.enumerated().map { (y, row) in
            row.enumerated().map { (x, _) in
                Vertex(identifier: "\(x),\(y)")
            }
        }
        vertices.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, vertex) in
                for (dx, dy) in [
                    (1, 0),
                    (0, 1),
                    (-1, 0),
                    (0, -1)
                ] {
                    guard let neighbor = vertices[safe: y + dy]?[safe: x + dx] else { continue }
                    vertex.neighbors.append((neighbor, risks[y + dy][x + dx]))
                }
            }
        }
        let dijkstra = Dijkstra(vertices: Set(vertices.flatMap { $0 }))
        dijkstra.findShortestPaths(from: vertices[0][0])
        return vertices.last!.last!.pathLengthFromStart
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var risks = input.lines.map { line in line.compactMap { $0.wholeNumberValue } }
        risks = risks.map { row in
            var row = row
            product(1...4, row).forEach { (index, item) in
                let newValue = item + index
                row.append(newValue > 9 ? newValue - 9 : newValue)
            }
            return row
        }
        product(1...4, risks).forEach { (index, row) in
            risks.append(
                row.map { item in
                    let newValue = item + index
                    return newValue > 9 ? newValue - 9 : newValue
                }
            )
        }
        let vertices = risks.enumerated().map { (y, row) in
            row.enumerated().map { (x, _) in
                Vertex(identifier: "\(x),\(y)")
            }
        }
        vertices.enumerated().forEach { (y, row) in
            row.enumerated().forEach { (x, vertex) in
                for (dx, dy) in [
                    (1, 0),
                    (0, 1),
                    (-1, 0),
                    (0, -1)
                ] {
                    guard let neighbor = vertices[safe: y + dy]?[safe: x + dx] else { continue }
                    vertex.neighbors.append((neighbor, risks[y + dy][x + dx]))
                }
            }
        }
        let dijkstra = Dijkstra(vertices: Set(vertices.flatMap { $0 }))
        dijkstra.findShortestPaths(from: vertices[0][0])
        return vertices.last!.last!.pathLengthFromStart
    }

    class Vertex: Hashable, Equatable {
        open var identifier: String
        open var neighbors: [(Vertex, Int)] = []
        open var pathLengthFromStart = Int.max

        public init(identifier: String) {
            self.identifier = identifier
        }

        open func clearCache() {
            pathLengthFromStart = Int.max
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier.hashValue)
        }

        static func ==(lhs: Day15.Vertex, rhs: Day15.Vertex) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }

    class Dijkstra {
        private var totalVertices: Set<Vertex>

        public init(vertices: Set<Vertex>) {
            totalVertices = vertices
        }

        private func clearCache() {
            totalVertices.forEach { $0.clearCache() }
        }

        public func findShortestPaths(from startVertex: Vertex) {
            clearCache()
            var currentVertices = self.totalVertices
            startVertex.pathLengthFromStart = 0
            var currentVertex: Vertex? = startVertex
            var potentialVertices = Set<Vertex>()
            while let vertex = currentVertex {
                currentVertices.remove(vertex)
                potentialVertices.remove(vertex)
                let filteredNeighbors = vertex.neighbors.filter { currentVertices.contains($0.0) }
                for neighbor in filteredNeighbors {
                    let neighborVertex = neighbor.0
                    let weight = neighbor.1

                    let theoreticNewWeight = vertex.pathLengthFromStart + weight
                    if theoreticNewWeight < neighborVertex.pathLengthFromStart {
                        neighborVertex.pathLengthFromStart = theoreticNewWeight
                        potentialVertices.insert(neighborVertex)
                    }
                }
                if currentVertices.isEmpty {
                    currentVertex = nil
                    break
                }
                currentVertex = potentialVertices.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
            }
        }
    }
}
