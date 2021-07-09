//
//  Sequence.swift
//  AppUplift
//
//  Created by Vitali Kurlovich on 14.05.21.
//

import Foundation

public
extension Sequence {
    /**
     Count of elements in the sequence selected by predicate
     */
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
}
