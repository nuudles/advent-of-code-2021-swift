//
//  String+Helpers.swift
//  AdventOfCode
//
//  Created by Christopher Luu on 12/2/21.
//

import Foundation

extension String {
    var lines: [Substring] {
        split(separator: "\n")
    }

    var ints: [Int] {
        lines.compactMap { Int($0) }
    }
}
