//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 2.07.21.
//

import Foundation

public
extension Range where Bound == Date {
    /**
     Expand date range by `Calendar.Component`
     */
    func expanded(by component: Calendar.Component, calendar: Calendar = Calendar.current) -> Range<Date> {
        let lower = lowerBound.lowerBounds(by: component, calendar: calendar)
        let upper = upperBound.upperBounds(lowerBound: lower, by: component, calendar: calendar)
        return lower ..< upper
    }
}

private
extension Date {
    func lowerBounds(by component: Calendar.Component, calendar: Calendar) -> Date {
        matchLower(for: self, by: component, calendar: calendar)
    }

    func upperBounds(lowerBound: Date, by component: Calendar.Component, calendar: Calendar) -> Date {
        matchUpper(lowerBound: lowerBound, for: self, by: component, calendar: calendar)
    }
}

private
func matchLower(for date: Date, by component: Calendar.Component, calendar: Calendar) -> Date {
    let requestComponents = dateComponents(by: component)
    if requestComponents.isEmpty {
        return date
    }

    let components = calendar.dateComponents(requestComponents, from: date)

    var current = calendar.date(from: components)!

    var lastDate = current

    let adding = addingComponent(for: component)

    if current == date {
        let prev = calendar.date(byAdding: adding, value: -1, to: current)!
        let prevComponents = calendar.dateComponents(requestComponents, from: prev)

        if prevComponents.transfrom(by: component) != components.transfrom(by: component) {
            return current
        }
    }

    var last = components
    repeat {
        current = lastDate
        lastDate = calendar.date(byAdding: adding, value: -1, to: current)!

        last = calendar.dateComponents(requestComponents, from: lastDate)

    } while last.transfrom(by: component) == components.transfrom(by: component)

    return current
}

private
func matchUpper(lowerBound: Date, for date: Date, by component: Calendar.Component, calendar: Calendar) -> Date {
    let requestComponents = dateComponents(by: component)
    if requestComponents.isEmpty {
        return date
    }

    let components = calendar.dateComponents(requestComponents, from: date)

    var current = calendar.date(from: components)!

    let adding = addingComponent(for: component)

    if current == date, lowerBound < current {
        let prev = calendar.date(byAdding: adding, value: -1, to: current)!
        let prevComponents = calendar.dateComponents(requestComponents, from: prev)

        if prevComponents.transfrom(by: component) != components.transfrom(by: component) {
            return current
        }
    }

    var lastDate = current

    var last = components

    repeat {
        current = lastDate

        lastDate = calendar.date(byAdding: adding, value: 1, to: current)!
        last = calendar.dateComponents(requestComponents, from: lastDate)

    } while last.transfrom(by: component) == components.transfrom(by: component)

    return lastDate
}

private
func addingComponent(for component: Calendar.Component) -> Calendar.Component {
    switch component {
    case .weekdayOrdinal:
        return .day
    case .weekOfMonth:
        return .day
    case .weekOfYear:
        return .day

    case .yearForWeekOfYear:
        return .day

    case .year:
        return .day

    default:
        return component
    }
}

private
extension DateComponents {
    func transfrom(by component: Calendar.Component) -> DateComponents {
        switch component {
        case .weekdayOrdinal, .weekOfMonth, .weekOfYear:
            var components = self
            components.year = nil
            components.month = nil
            components.day = nil

            return components

        case .yearForWeekOfYear:
            var components = self
            components.year = nil
            components.month = nil
            components.day = nil

            components.weekOfYear = nil

            return components

        default:
            return self
        }
    }
}

private
func dateComponents(by component: Calendar.Component) -> Set<Calendar.Component> {
    switch component {
    case .year:
        return [.year]
    case .month:
        return [.year, .month]
    case .day:
        return [.year, .month, .day]
    case .hour:
        return [.year, .month, .day, .hour]
    case .minute:
        return [.year, .month, .day, .hour, .minute]
    case .second:
        return [.year, .month, .day, .hour, .minute, .second]

    case .weekday:
        return [.year, .month, .day, .weekday]

    case .weekdayOrdinal:
        return [.year, .month, .day, .weekdayOrdinal]
    case .weekOfMonth:
        return [.year, .month, .day, .weekOfMonth]
    case .weekOfYear:
        return [.year, .month, .day, .weekOfYear]
    case .yearForWeekOfYear:
        return [.year, .weekOfYear, .yearForWeekOfYear]

    default:
        return []
    }
}
