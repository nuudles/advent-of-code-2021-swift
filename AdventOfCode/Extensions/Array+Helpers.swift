//
//  Array+Helpers.swift
//  AdventOfCode
//
//  Created by Christopher Luu on 12/9/21.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        } else {
            return nil
        }
    }
}
