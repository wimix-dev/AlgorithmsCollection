//
//  Sequence+Group.swift
//  AppUplift
//
//  Created by Vitali Kurlovich on 20.05.21.
//

import Foundation

public
extension Sequence {
    /**
     Group elements by similar properties
     - Parameter isSameGroupElement: Predicate return true for two elements in the same group otherwise false.
     - Returns: Arrays with elements with the same group
     */
    func group(with isSameGroupElement: @escaping (_ last: Element, _ current: Element) throws -> Bool) rethrows -> [[Element]] {
        var groups: [[Element]] = []
        var group: [Element] = []

        var lastElement: Element?

        for element in self {
            if let last = lastElement {
                if try isSameGroupElement(last, element) {
                    group.append(element)
                } else {
                    groups.append(group)
                    group.removeAll()
                }

            } else {
                group.append(element)
            }

            lastElement = element
        }

        if !group.isEmpty {
            groups.append(group)
        }

        return groups
    }
}

public
extension Sequence {
    /**
     Group elements by date components
     */
    func group(by components: Set<Calendar.Component> = [.day, .month, .year],
               with calendar: Calendar = Calendar.current, dateClosure: @escaping (Element) throws -> Date) rethrows -> [[Element]]
    {
        try group { last, current in
            let lastDate = try dateClosure(last)
            let currentDate = try dateClosure(current)

            let lastComponents = calendar.dateComponents(components, from: lastDate)
            let currentComponents = calendar.dateComponents(components, from: currentDate)

            return lastComponents == currentComponents
        }
    }
}

public
extension Sequence {
    /**
     Group elements by type that supported `CaseIterable` protocol
     */
    func group<E: CaseIterable, S: Sequence>(type _: E.Type, emunClosure: @escaping (Element) throws -> S) rethrows -> [[Element]] where E.AllCases.Element: Hashable, S.Element == E.AllCases.Element {
        var groups: [[Element]] = []

        for value in E.allCases {
            let filtered = try filter { element in
                let set = try emunClosure(element)
                return set.contains(value)
            }

            groups.append(filtered)
        }

        return groups
    }
}
