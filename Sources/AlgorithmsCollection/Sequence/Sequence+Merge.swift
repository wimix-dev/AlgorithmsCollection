//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 30.06.21.
//

import Foundation

public
extension Sequence {
    /**
     Merge two sequences into an array of R items
     - Parameter source: Source sequence
     - Parameter isCanMerged: Returns true if item can be merged
     - Parameter first: Item from sequence
     - Parameter second: Item from merged sequence
     - Parameter merge: Returns instance of R or nil for skipping
     - Parameter first: Item from sequence or nil
     - Parameter second: Item from merged sequence or nil

     - Returns:
         Array of R items

     - Complexity: O(n*m) where n and m are the lengths of the sequences. If items in sequences in same order, complexity can be decreased to O(n)
     - Warning: This function has a big complexity, for a large sequence of unordered items. Presorting can increase performance. Needs use background execution for random data to avoiding hitches on the UI

     */

    func merged<S: Sequence, R>(with source: S,
                                isCanMerged: @escaping (_ first: Element, _ second: S.Element) throws -> Bool,
                                merge: @escaping (_ first: Element?, _ second: S.Element?) throws -> R?) rethrows -> [R]
    {
        var source = Array(source)

        var result: [R] = []
        result.reserveCapacity(underestimatedCount + source.underestimatedCount)

        for item in self {
            let srcIndex = try source.firstIndex { src in
                try isCanMerged(item, src)
            }

            if let index = srcIndex {
                let srcItem = source[index]
                source.remove(at: index)

                if let mergedItem = try merge(item, srcItem) {
                    result.append(mergedItem)
                }
            } else {
                if let mergedItem = try merge(item, nil) {
                    result.append(mergedItem)
                }
            }
        }

        for src in source {
            if let mergedItem = try merge(nil, src) {
                result.append(mergedItem)
            }
        }

        return result
    }
}
