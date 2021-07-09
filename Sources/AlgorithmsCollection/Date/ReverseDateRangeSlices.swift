//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 2.07.21.
//

import Foundation

public
struct ReverseDateRangeSlices {
    let range: Range<Date>
    let calendar: Calendar
    let component: Calendar.Component
    let step: Int
}

extension ReverseDateRangeSlices: Sequence {
    public typealias Element = Iterator.Element

    public
    __consuming func makeIterator() -> Iterator {
        Iterator(range: range, component: component, step: step, calendar: calendar)
    }
}

public
extension DateRangeSlices {
    func reversed() -> ReverseDateRangeSlices {
        .init(range: range, calendar: calendar, component: component, step: step)
    }
}

public
extension ReverseDateRangeSlices {
    func reversed() -> DateRangeSlices {
        .init(range: range, calendar: calendar, component: component, step: step)
    }
}

public extension ReverseDateRangeSlices {
    struct Iterator: IteratorProtocol {
        public typealias Element = Range<Date>

        let range: Range<Date>
        let calendar: Calendar
        let component: Calendar.Component

        let step: Int

        let expandedRange: Range<Date>

        var current: Date
        var offset: Int

        public
        mutating func next() -> Self.Element? {
            if current >= range.upperBound {
                return nil
            }

            var upper = calendar.date(byAdding: component, value: offset, to: expandedRange.lowerBound) ?? current

            if upper > range.upperBound {
                upper = range.upperBound
            }

            offset += step

            defer {
                current = upper
            }

            return current ..< upper
        }

        init(range: Range<Date>, component: Calendar.Component, step: Int, calendar: Calendar) {
            precondition(step > 0)

            self.range = range
            self.calendar = calendar
            self.component = component
            self.step = step
            offset = step

            current = range.lowerBound
            expandedRange = range.expanded(by: component, calendar: calendar)
        }
    }
}
