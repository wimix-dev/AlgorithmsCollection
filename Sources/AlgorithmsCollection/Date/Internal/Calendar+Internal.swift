//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 9.07.21.
//

import Foundation

extension Date {
    func dateComponents(_ components: Set<Calendar.Component>, calendar: Calendar) -> DateComponents {
        var dateComponents = calendar.dateComponents(components, from: self)

        if components.contains(.quarter) {
            quarterDateFormatter.calendar = calendar
            quarterDateFormatter.timeZone = calendar.timeZone

            let quartalString = quarterDateFormatter.string(from: self)
            dateComponents.quarter = Int(quartalString)
        }

        return dateComponents
    }

    func component(_ component: Calendar.Component, calendar: Calendar) -> Int {
        if component == .quarter {
            quarterDateFormatter.calendar = calendar
            quarterDateFormatter.timeZone = calendar.timeZone

            let quartalString = quarterDateFormatter.string(from: self)
            return Int(quartalString) ?? 0
        }

        return calendar.component(component, from: self)
    }
}

private let quarterDateFormatter: DateFormatter = {
    let formatter = DateFormatter()

    let timeZone = TimeZone(secondsFromGMT: 0)!
    formatter.timeZone = timeZone
    formatter.locale = posixUSLocale

    formatter.dateFormat = "Q"

    return formatter
}()

private let posixUSLocale = Locale(identifier: "en_US_POSIX")
