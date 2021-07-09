//
//  File.swift
//
//
//  Created by Vitali Kurlovich on 7.07.21.
//

import Foundation

public
extension Date {
    init(_ from: String,
         calendar: Calendar = calendarUTC,
         locale: Locale = posixUSLocale)
    {
        dateFormatter.locale = locale

        if from.range(of: #":\d\d:\d"#, options: .regularExpression) != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        } else if from.contains(":") {
            dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }

        var calendar = calendar

        calendar.locale = locale

        dateFormatter.calendar = calendar
        dateFormatter.timeZone = calendar.timeZone

        self = dateFormatter.date(from: from)!
    }
}

public
extension Range where Bound == Date {
    static func range(_ from: String, to: String, calendar: Calendar = calendarUTC, locale _: Locale = posixUSLocale) -> Range<Date> {
        let start = Date(from, calendar: calendar)
        let end = Date(to, calendar: calendar)

        return start ..< end
    }
}

private let dateFormatter = DateFormatter()

public
let calendarUTC: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    let timeZone = TimeZone(secondsFromGMT: 0)!

    calendar.timeZone = timeZone
    return calendar
}()

public
let posixUSLocale = Locale(identifier: "en_US_POSIX")

extension Calendar.Identifier: CaseIterable {
    public static var allCases: [Calendar.Identifier] {
        [.gregorian,

         .buddhist,

         .chinese,

         .coptic,

         .ethiopicAmeteMihret,

         .ethiopicAmeteAlem,

         .hebrew,

         .iso8601,

         .indian,

         .islamic,

         .islamicCivil,

         .japanese,

         .persian,

         .republicOfChina,

         .islamicTabular,

         .islamicUmmAlQura]
    }
}
