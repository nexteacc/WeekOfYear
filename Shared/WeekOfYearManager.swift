//
//  WeekOfYearManager.swift
//  WeekOfYear
//
//  Created by Sheng on 10/24/24.
//

import Foundation

public struct WeekOfYearManager {
    public static func calculateRemainingWeeks() -> (weeks: String, debug: String) {
        var calendar = Calendar.current
        let timeZone = TimeZone.current
        calendar.timeZone = timeZone

        let now = Date()


        let currentYear = calendar.component(.year, from: now)
        guard let lastDayOfYear = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 31)) else {
            return ("00", "Error calculating date")
        }


        let totalWeeksRange = calendar.range(of: .weekOfYear, in: .year, for: lastDayOfYear)
        let totalWeeks = totalWeeksRange?.count ?? 52


        let currentWeek = calendar.component(.weekOfYear, from: now)


        let remainingWeeks = totalWeeks - currentWeek


        let adjustedRemainingWeeks = max(0, remainingWeeks)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium

        let debugString = """
        Current Date: \(dateFormatter.string(from: now))
        Time Zone: \(timeZone.identifier)
        Week: \(currentWeek) of \(totalWeeks)
        Remaining: \(adjustedRemainingWeeks)
        """

        return (String(format: "%02d", adjustedRemainingWeeks), debugString)
    }

    public init() {}
}
