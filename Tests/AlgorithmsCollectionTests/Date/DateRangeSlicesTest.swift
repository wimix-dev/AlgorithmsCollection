//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 2.07.21.
//

@testable import AlgorithmsCollection
import XCTest

final class DateRangeSlicesTest: XCTestCase {
    func testDateRangeSlicesByDay() throws {
        let range = dateRange("2020-10-12 12:46", to: "2020-10-15 4:12")

        let slices = DateRangeSlices(from: range.lowerBound, to: range.upperBound, by: .day, calendar: calendarUTC)

        let result = slices.map { $0 }

        let expected: [Range<Date>] = [
            dateRange("2020-10-12 12:46", to: "2020-10-13 0:00"),
            dateRange("2020-10-13 0:00", to: "2020-10-14 0:00"),
            dateRange("2020-10-14 0:00", to: "2020-10-15 0:00"),
            dateRange("2020-10-15 0:00", to: "2020-10-15 4:12"),
        ]

        XCTAssertEqual(result, expected)
    }

    func testDateRangeSlicesByDayWithStep() throws {
        let range = dateRange("2020-10-12 12:46", to: "2020-10-20 4:12")

        let slices = DateRangeSlices(from: range.lowerBound, to: range.upperBound, by: .day, step: 3, calendar: calendarUTC)

        let result = slices.map { $0 }

        let expected: [Range<Date>] = [
            dateRange("2020-10-12 12:46", to: "2020-10-15 0:00"),
            dateRange("2020-10-15 0:00", to: "2020-10-18 0:00"),
            dateRange("2020-10-18 0:00", to: "2020-10-20 4:12"),
        ]

        XCTAssertEqual(result, expected)
    }
}

private
func date(_ from: String, calendar: Calendar = calendarUTC,
          locale: Locale = Locale(identifier: "en_US_POSIX")) -> Date
{
    Date(from, calendar: calendar, locale: locale)
}

private
func dateRange(_ from: String, to: String,
               calendar: Calendar = calendarUTC,
               locale: Locale = posixUSLocale) -> Range<Date>
{
    Range<Date>.range(from, to: to, calendar: calendar, locale: locale)
}
