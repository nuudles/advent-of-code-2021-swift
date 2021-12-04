//
//  PrintIt.swift
//  AdventOfCode
//
//  Created by Christopher Luu on 12/4/21.
//

import Foundation

extension CustomDebugStringConvertible {
    func printIt() -> Self {
        debugPrint(self)
        return self
    }
}
