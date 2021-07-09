//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 1.07.21.
//

import Foundation
/**

 */
public
struct DateRangeSlices {
    let range: Range<Date>
    let calendar: Calendar
    let component: Calendar.Component
    let step: Int
}

public
extension Range where Bound == Date {
    func slices(timeZone: TimeZone? = nil,
                by component: Calendar.Component,
                step: Int = 1,
                calendar: Calendar = Calendar.current) -> DateRangeSlices
    {
        .init(from: lowerBound, to: upperBound, timeZone: timeZone, by: component, step: step, calendar: calendar)
    }
}

public
extension DateRangeSlices {
    init(from: Date, to: Date, timeZone: TimeZone? = nil, by component: Calendar.Component, step: Int = 1, calendar: Calendar = Calendar.current) {
        precondition(from < to)
        precondition(step > 0)

        var calendar = calendar
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }

        range = from ..< to
        self.calendar = calendar
        self.component = component
        self.step = step
    }
}

extension DateRangeSlices: Sequence {
    public typealias Element = Iterator.Element

    public
    __consuming func makeIterator() -> Iterator {
        Iterator(range: range, component: component, step: step, calendar: calendar)
    }
}

public
extension DateRangeSlices {
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
