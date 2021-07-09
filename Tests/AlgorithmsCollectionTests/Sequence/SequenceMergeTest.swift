//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 30.06.21.
//

@testable import AlgorithmsCollection
import XCTest

private
struct Composition: Equatable {
    let key: Int
    let text: String
    let second: String
}

final class SequenceMergeTest: XCTestCase {
    func testMerge() {
        let left = [
            (key: 0, text: "A"),
            (key: 1, text: "B"),
            (key: 2, text: "C"),
            (key: 3, text: "D"),
        ]

        let right = [
            (key: 0, second: "A1"),
            (key: 1, second: "B1"),
            (key: 4, second: "E1"),
            (key: 5, second: "F1"),
        ]

        let result =
            left.merged(with: right) { left, right in
                left.key == right.key
            } merge: { left, right -> Composition? in
                if let left = left, let right = right {
                    return .init(key: left.key, text: left.text, second: right.second)
                } else if let left = left {
                    return .init(key: left.key, text: left.text, second: "uncknown")
                } else if let right = right {
                    return .init(key: right.key, text: "uncknown", second: right.second)
                }
                return nil
            }

        let expected: [Composition] = [
            .init(key: 0, text: "A", second: "A1"),
            .init(key: 1, text: "B", second: "B1"),
            .init(key: 2, text: "C", second: "uncknown"),
            .init(key: 3, text: "D", second: "uncknown"),
            .init(key: 4, text: "uncknown", second: "E1"),
            .init(key: 5, text: "uncknown", second: "F1"),
        ]

        XCTAssertEqual(result, expected)
    }

    func testMergeWithSkipElements() {
        let left = [
            (key: 0, text: "A"),
            (key: 1, text: "B"),
            (key: 2, text: "C"),
            (key: 3, text: "D"),
        ]

        let right = [
            (key: 0, second: "A1"),
            (key: 1, second: "B1"),
            (key: 4, second: "E1"),
            (key: 5, second: "F1"),
        ]

        let result =
            left.merged(with: right) { left, right in
                left.key == right.key
            } merge: { left, right -> Composition? in
                if let left = left, let right = right {
                    return .init(key: left.key, text: left.text, second: right.second)
                }
                return nil
            }

        let expected: [Composition] = [
            .init(key: 0, text: "A", second: "A1"),
            .init(key: 1, text: "B", second: "B1"),
        ]

        XCTAssertEqual(result, expected)
    }
}
