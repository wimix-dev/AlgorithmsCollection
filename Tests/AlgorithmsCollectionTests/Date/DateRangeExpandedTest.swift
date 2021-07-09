//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 2.07.21.
//

import Foundation

@testable import AlgorithmsCollection
import XCTest

final class DateRangeExpandedTest: XCTestCase {
    func testDateRangeExpandedNanoSecond() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-12 12:46:12", to: "2020-10-12 12:46:12")
        expanded = expanded.expanded(by: .nanosecond, calendar: calendar)

        var expected = dateRange("2020-10-12 12:46:12", to: "2020-10-12 12:46:12")

        XCTAssertEqual(expanded, expected)

        expanded = expanded.expanded(by: .nanosecond, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46:01")
        expanded = expanded.expanded(by: .nanosecond, calendar: calendar)

        expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46:01")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .nanosecond, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedSecond() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-12 12:46:12", to: "2020-10-12 12:46:12")
        expanded = expanded.expanded(by: .second, calendar: calendar)

        var expected = dateRange("2020-10-12 12:46:12", to: "2020-10-12 12:46:13")

        XCTAssertEqual(expanded, expected)

        expanded = expanded.expanded(by: .second, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46:01")
        expanded = expanded.expanded(by: .second, calendar: calendar)

        expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46:01")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .second, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")
        expanded = expanded.expanded(by: .second, calendar: calendar)

        expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")

        XCTAssertEqual(expanded, expected)

        expanded = expanded.expanded(by: .second, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedMinute() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46")
        expanded = expanded.expanded(by: .minute, calendar: calendar)

        var expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")

        XCTAssertEqual(expanded, expected)

        expanded = expanded.expanded(by: .minute, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:46:01")
        expanded = expanded.expanded(by: .minute, calendar: calendar)

        expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .minute, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")
        expanded = expanded.expanded(by: .minute, calendar: calendar)

        expected = dateRange("2020-10-12 12:46", to: "2020-10-12 12:47")

        XCTAssertEqual(expanded, expected)

        expanded = expanded.expanded(by: .minute, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedHour() throws {
        // hour
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-12 12:00", to: "2020-10-12 12:00")
        expanded = expanded.expanded(by: .hour, calendar: calendar)

        var expected = dateRange("2020-10-12 12:00", to: "2020-10-12 13:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .hour, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:00", to: "2020-10-12 13:00")
        expanded = expanded.expanded(by: .hour, calendar: calendar)

        expected = dateRange("2020-10-12 12:00", to: "2020-10-12 13:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .hour, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-13 12:46")
        expanded = expanded.expanded(by: .hour, calendar: calendar)

        expected = dateRange("2020-10-12 12:00", to: "2020-10-13 13:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .hour, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-13 12:46:01")
        expanded = expanded.expanded(by: .hour, calendar: calendar)

        expected = dateRange("2020-10-12 12:00", to: "2020-10-13 13:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .hour, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedDay() throws {
        // Day

        let calendar = calendarUTC

        var expanded = dateRange("2020-10-12 00:00", to: "2020-10-12 00:00")
        expanded = expanded.expanded(by: .day, calendar: calendar)

        var expected = dateRange("2020-10-12 00:00", to: "2020-10-13 00:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .day, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 2:40", to: "2020-10-12 13:12")
        expanded = expanded.expanded(by: .day, calendar: calendar)

        expected = dateRange("2020-10-12 00:00", to: "2020-10-13 00:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .day, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 00:00", to: "2020-10-17 00:00")
        expanded = expanded.expanded(by: .day, calendar: calendar)

        expected = dateRange("2020-10-12 00:00", to: "2020-10-17 00:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .day, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 12:46", to: "2020-10-17 16:42:01")
        expanded = expanded.expanded(by: .day, calendar: calendar)

        expected = dateRange("2020-10-12 00:00", to: "2020-10-18 00:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .day, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-12 1:12", to: "2020-10-17 14:43")
        expanded = expanded.expanded(by: .day, calendar: calendar)

        expected = dateRange("2020-10-12 0:00", to: "2020-10-18 0:00")

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .day, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedWeekday() throws {
        // Weekday

        let calendar = calendarUTC

        // let locale = Locale(identifier: "ru_RU")
        // calendar.locale = locale

        var expanded = dateRange("2021-01-01 00:00", to: "2021-01-01 00:00", calendar: calendar)
        expanded = expanded.expanded(by: .weekday, calendar: calendar)

        var expected = dateRange("2021-01-01 00:00", to: "2021-01-02 00:00", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekday, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2021-01-01 12:12", to: "2021-01-01 13:55", calendar: calendar)
        expanded = expanded.expanded(by: .weekday, calendar: calendar)
        expected = dateRange("2021-01-01 00:00", to: "2021-01-02 00:00", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekday, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedWeekdayOrdinal() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-11-29", to: "2020-11-29", calendar: calendar)
        expanded = expanded.expanded(by: .weekdayOrdinal, calendar: calendar)

        var expected = dateRange("2020-11-29", to: "2020-12-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekdayOrdinal, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-12-02", to: "2020-12-02", calendar: calendar)
        expanded = expanded.expanded(by: .weekdayOrdinal, calendar: calendar)

        expected = dateRange("2020-12-01", to: "2020-12-08", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekdayOrdinal, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-12-01", to: "2020-12-08", calendar: calendar)

        expected = dateRange("2020-12-01", to: "2020-12-08", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekdayOrdinal, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedWeekOfMonth() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-06", to: "2020-10-06", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        var expected = dateRange("2020-10-04", to: "2020-10-11", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-02", to: "2020-10-02", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2020-10-01", to: "2020-10-04", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2021-02-28", to: "2021-02-28", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2021-02-28", to: "2021-03-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-12-22", to: "2020-12-24", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2020-12-20", to: "2020-12-27", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2021-05-31", to: "2021-05-31", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2021-05-30", to: "2021-06-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-06 2:34", to: "2020-10-06 13:45", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2020-10-04", to: "2020-10-11", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-02 8:33", to: "2020-10-02 8:34", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)

        expected = dateRange("2020-10-01", to: "2020-10-04", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfMonth, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        // TODO: Cases with RU locale
    }

    func testDateRangeExpandedWeekOfYear() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfYear, calendar: calendar)

        var expected = dateRange("2019-12-29", to: "2020-01-05", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfYear, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2019-12-30", to: "2019-12-30", calendar: calendar)
        expanded = expanded.expanded(by: .weekOfYear, calendar: calendar)

        expected = dateRange("2019-12-29", to: "2020-01-05", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .weekOfYear, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedYearForWeekOfYear() throws {
        // 2019-12-29

        let calendar = calendarUTC

        var expanded = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)
        expanded = expanded.expanded(by: .yearForWeekOfYear, calendar: calendar)

        var expected = dateRange("2019-12-29", to: "2020-12-27", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2019-12-30", to: "2019-12-31", calendar: calendar)
        expanded = expanded.expanded(by: .yearForWeekOfYear, calendar: calendar)

        expected = dateRange("2019-12-29", to: "2020-12-27", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        //

        expanded = dateRange("2020-11-17", to: "2020-11-27", calendar: calendar)
        expanded = expanded.expanded(by: .yearForWeekOfYear, calendar: calendar)

        expected = dateRange("2019-12-29", to: "2020-12-27", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedForMonth() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-01-01", to: "2020-01-01", calendar: calendar)
        expanded = expanded.expanded(by: .month, calendar: calendar)

        var expected = dateRange("2020-01-01", to: "2020-02-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .month, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-01-03", to: "2020-02-01", calendar: calendar)
        expanded = expanded.expanded(by: .month, calendar: calendar)

        expected = dateRange("2020-01-01", to: "2020-02-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .month, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-01-03", to: "2020-01-03", calendar: calendar)
        expanded = expanded.expanded(by: .month, calendar: calendar)

        expected = dateRange("2020-01-01", to: "2020-02-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .month, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-01-03", to: "2020-01-06", calendar: calendar)
        expanded = expanded.expanded(by: .month, calendar: calendar)

        expected = dateRange("2020-01-01", to: "2020-02-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .month, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedForYear() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-01-01", to: "2020-01-01", calendar: calendar)
        expanded = expanded.expanded(by: .year, calendar: calendar)

        var expected = dateRange("2020-01-01", to: "2021-01-01", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .year, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedWeekdaySandbox() throws {
        let calendar = Calendar(identifier: .gregorian)

        // let dates = dateRange("1001-10-17", to: "2021-10-10").slices(by: .year, calendar: calendar)

        let startDate = Date()

        // calendar.date(byAdding: .year, value: 1, to: date)

        // var calendar = calendarUTC
        //   let locale = Locale(identifier: "ru_RU")
        //   calendar.locale = locale

        for year in 1 ..< 2060 {
            let date = calendar.date(byAdding: .year, value: -year, to: startDate)!

            let weekday = calendar.component(.weekday, from: date)
            let weekdayOrdinal = calendar.component(.weekdayOrdinal, from: date)
            let weekOfYear = calendar.component(.weekOfYear, from: date)
            let weekOfMonth = calendar.component(.weekOfMonth, from: date)
            let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: date)
            let era = calendar.component(.era, from: date)

            
            let quarter =  date.component(.quarter, calendar: calendar)
            
            let formatter = DateFormatter()
            formatter.calendar = calendar
            formatter.dateFormat = "yyyy-MM-dd' 'EE' 'GGGG' 'Q"

            let dateString = formatter.string(from: date)

            print("\(dateString) quarter:\(quarter)  era:\(era)")
        }

        print("firstWeekday: \(calendar.firstWeekday)")
    }

    func testCalendarRangesSandbox() {
        // let range =  calendar.maximumRange(of: .era)

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)

            let min = calendar.minimumRange(of: .era)!
            let max = calendar.maximumRange(of: .era)!

            print("era range:\(min) - \(max) for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)

            let min = calendar.minimumRange(of: .year)!
            let max = calendar.maximumRange(of: .year)!

            print("year range:\(min) - \(max) for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)

            let min = calendar.minimumRange(of: .quarter)!
            let max = calendar.maximumRange(of: .quarter)!

            print("quarter range:\(min) - \(max)  for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)

            let min = calendar.minimumRange(of: .month)!
            let max = calendar.maximumRange(of: .month)!

            print("month range:\(min) - \(max)  for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)

            let min = calendar.maximumRange(of: .weekday)!
            let max = calendar.maximumRange(of: .weekday)!

            print("weekday range:\(min) - \(max)  for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)
            let min = calendar.minimumRange(of: .day)!
            let max = calendar.maximumRange(of: .day)!

            print("day range:\(min) - \(max)  for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)
            let min = calendar.minimumRange(of: .hour)!
            let max = calendar.maximumRange(of: .hour)!

            print("hour range:\(min) - \(max)  for:\(identifier)")
        }

        print("")

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)
            let min = calendar.minimumRange(of: .minute)!
            let max = calendar.maximumRange(of: .minute)!

            print("minute range:\(min) - \(max)  for:\(identifier)")
        }

        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd' 'EE' 'GGGG' 'Q"

        var date = Date()

        for identifier in Calendar.Identifier.allCases {
            let calendar = Calendar(identifier: identifier)
            formatter.calendar = calendar

            let dateComponents = calendar.dateComponents([.quarter], from: date)

            let dateString = formatter.string(from: date)

            print("\(dateString) for:\(identifier)")

            // print("dateComponents:\(dateComponents)")
        }

        let calendar = Calendar(identifier: .gregorian)

        let dateComponents = DateComponents(calendar: calendar, year: 2021, quarter: 2)

        date = calendar.date(from: dateComponents)!

        formatter.calendar = calendar

        let dateString = formatter.string(from: date)

        print("\(dateString)")
    }

    func testDateRangeExpandedQuarter() throws {
        let calendar = calendarUTC
        var expanded = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)
        expanded = expanded.expanded(by: .quarter, calendar: calendar)

        var expected = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .quarter, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2019-12-30", to: "2019-12-31", calendar: calendar)
        expanded = expanded.expanded(by: .quarter, calendar: calendar)

        expected = dateRange("2019-12-30", to: "2019-12-31", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .quarter, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedEra() throws {
        let calendar = calendarUTC
        var expanded = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)
        expanded = expanded.expanded(by: .era, calendar: calendar)

        var expected = dateRange("2019-12-29", to: "2019-12-29", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .era, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2019-12-30", to: "2019-12-31", calendar: calendar)
        expanded = expanded.expanded(by: .era, calendar: calendar)

        expected = dateRange("2019-12-30", to: "2019-12-31", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .era, calendar: calendar)
        XCTAssertEqual(expanded, expected)
    }

    func testDateRangeExpandedCalendarAndTimeZone() throws {
        let calendar = calendarUTC

        var expanded = dateRange("2020-10-06", to: "2020-10-06", calendar: calendar)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)

        var expected = dateRange("2020-10-06", to: "2020-10-06", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-06 12:32", to: "2020-10-06 13:34", calendar: calendar)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)

        expected = dateRange("2020-10-06 12:32", to: "2020-10-06 13:34", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .calendar, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-06", to: "2020-10-06", calendar: calendar)
        expanded = expanded.expanded(by: .timeZone, calendar: calendar)

        expected = dateRange("2020-10-06", to: "2020-10-06", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .timeZone, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        expanded = dateRange("2020-10-06 12:32", to: "2020-10-06 13:34", calendar: calendar)
        expanded = expanded.expanded(by: .timeZone, calendar: calendar)

        expected = dateRange("2020-10-06 12:32", to: "2020-10-06 13:34", calendar: calendar)

        XCTAssertEqual(expanded, expected)
        expanded = expanded.expanded(by: .timeZone, calendar: calendar)
        XCTAssertEqual(expanded, expected)

        // String(format: <#T##String#>, <#T##arguments: CVarArg...##CVarArg#>)
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

extension Calendar {
    var weekdaySymbolsInLocalOrder: [String] {
        let symbols = weekdaySymbols

        if firstWeekday == 1 {
            return symbols
        }

        let range = maximumRange(of: .weekday)!
        var result: [String] = []
        for offset in (firstWeekday - 1) ..< (range.upperBound - 1) {
            let index = symbols.index(symbols.startIndex, offsetBy: offset)
            result.append(symbols[index])
        }

        for offset in (range.lowerBound - 1) ..< (firstWeekday - 1) {
            let index = symbols.index(symbols.startIndex, offsetBy: offset)
            result.append(symbols[index])
        }

        return result
    }
}
