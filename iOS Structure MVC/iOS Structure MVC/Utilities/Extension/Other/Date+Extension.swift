//
//  Date+Extension.swift
//  iOS Structure MVC
//
//  Created by vinhdd on 10/9/18.
//  Copyright © 2018 vinhdd. All rights reserved.
//

import UIKit
import Foundation

// MARK: - General
extension Date {
    init(year: Int, month: Int, day: Int, calendar: Calendar = AppConstants.calendar) {
        var dc = DateComponents()
        dc.year = year
        dc.month = month
        dc.day = day
        if let date = calendar.date(from: dc) {
            self.init(timeInterval: 0, since: date)
        } else {
            fatalError("Date component values were invalid.")
        }
    }
    
    init(hour: Int, minute: Int, second: Int, calendar: Calendar = AppConstants.calendar) {
        var dc = DateComponents()
        dc.hour = hour
        dc.minute = minute
        dc.second = second
        if let date = calendar.date(from: dc) {
            self.init(timeInterval: 0, since: date)
        } else {
            fatalError("Date component values were invalid.")
        }
    }
    
    var currentAge: Int? {
        let ageComponents = AppConstants.calendar.dateComponents([.year], from: self, to: Date())
        return ageComponents.year
    }

    var yesterday: Date? {
        return AppConstants.calendar.date(byAdding: .day, value: -1, to: self)
    }
    var tomorrow: Date? {
        return AppConstants.calendar.date(byAdding: .day, value: 1, to: self)
    }
    
    var weekday: Int {
        return AppConstants.calendar.component(.weekday, from: self)
    }
    
    var firstDayOfTheMonth: Date? {
        return AppConstants.calendar.date(from: AppConstants.calendar.dateComponents([.year,.month], from: self))
    }
    
    func isToday(calendar: Calendar = AppConstants.calendar) -> Bool {
        return calendar.isDateInToday(self)
    }
    
    func isYesterday(calendar: Calendar = AppConstants.calendar) -> Bool {
        return calendar.isDateInYesterday(self)
    }
    
    func isTomorrow(calendar: Calendar = AppConstants.calendar) -> Bool {
        return calendar.isDateInTomorrow(self)
    }
    
    func isWeekend(calendar: Calendar = AppConstants.calendar) -> Bool {
        return calendar.isDateInWeekend(self)
    }
    
    func isSamedayWith(date: Date, calendar: Calendar = AppConstants.calendar) -> Bool {
        return calendar.isDate(self, inSameDayAs: date)
    }
    
    func getComponents(calendar: Calendar = AppConstants.calendar, timeZone: TimeZone = AppConstants.timeZone) -> DateComponents {
        let dateComponents = DateComponents(calendar: calendar,
                                            timeZone: timeZone,
                                            era: calendar.component(.era, from: self),
                                            year: calendar.component(.year, from: self),
                                            month: calendar.component(.month, from: self),
                                            day: calendar.component(.day, from: self),
                                            hour: calendar.component(.hour, from: self),
                                            minute: calendar.component(.minute, from: self),
                                            second: calendar.component(.second, from: self),
                                            nanosecond: calendar.component(.nanosecond, from: self),
                                            weekday: calendar.component(.weekday, from: self),
                                            weekdayOrdinal: calendar.component(.weekdayOrdinal, from: self),
                                            quarter: calendar.component(.quarter, from: self),
                                            weekOfMonth: calendar.component(.weekOfMonth, from: self),
                                            weekOfYear: calendar.component(.weekOfYear, from: self),
                                            yearForWeekOfYear: calendar.component(.yearForWeekOfYear, from: self))
        return dateComponents
    }

    static func startOfMonth(date: Date) -> Date? {
        return AppConstants.calendar.date(from: AppConstants.calendar.dateComponents([.year, .month], from: AppConstants.calendar.startOfDay(for: date)))
    }
    
    static func getComponentFrom(string: String, format: String, calendar: Calendar = AppConstants.calendar, timeZone: TimeZone = AppConstants.timeZone) -> DateComponents? {
        if let date = getDateBy(string: string, format: format, calendar: calendar, timeZone: timeZone) {
            return date.getComponents(calendar: calendar, timeZone: timeZone)
        }
        return nil
    }
    
    static func endOfMonth(date: Date) -> Date? {
        if let startOfMonth = startOfMonth(date: date) {
            return AppConstants.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
        }
        return nil
    }
    
    static func dayEndOfMonth(date: Date) -> Int {
        if let startOfMonth = startOfMonth(date: date) {
            if let day = (AppConstants.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)?.getComponents().day) {
                return day
            }
        }
        return -1
    }
    
    static func getDateBy(string: String, format: String, calendar: Calendar = AppConstants.calendar, timeZone: TimeZone = AppConstants.timeZone) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        return formatter.date(from: string)
    }

    static func dateAt(timeInterval: Int, calendar: Calendar = AppConstants.calendar) -> DateComponents {
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return date.getComponents(calendar: calendar)
    }
    
    static func getHourMinuteSecondFrom(secondValue: Int) -> (hour: Int, minute: Int, second: Int) {
        return (secondValue / 3600, (secondValue % 3600) / 60, (secondValue % 3600) % 60)
    }
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
  
    func add(day: Int? = nil, month: Int? = nil, year: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date? {
        let calendar = AppConstants.calendar
        var dateComponent = DateComponents()
        if let year = year { dateComponent.year = year }
        if let month = month { dateComponent.month = month }
        if let day = day { dateComponent.day = day }
        if let hour = hour { dateComponent.hour = hour }
        if let minute = minute { dateComponent.minute = minute }
        if let second = second { dateComponent.second = second }
        return calendar.date(byAdding: dateComponent, to: self)
    }
    
    func stringBy(format: String, calendar: Calendar = AppConstants.calendar, timeZone: TimeZone = AppConstants.timeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
    func years(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func months(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    func weeks(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    
    func days(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    func hours(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minutes(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func seconds(from date: Date) -> Int {
        return AppConstants.calendar.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    func set(year: Int, month: Int, day: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        return self.set(year: year, calendar: calendar)?
            .set(month: month, calendar: calendar)?
            .set(day: day, calendar: calendar)
    }
    
    func set(hour: Int, minute: Int, second: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        return self.set(hour: hour, calendar: calendar)?
            .set(minute: minute, calendar: calendar)?
            .set(second: second, calendar: calendar)
    }
    
    func set(year: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.year = year
        return calendar.date(from: components)
    }
    
    func set(month: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.month = month
        return calendar.date(from: components)
    }
    
    func set(day: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.day = day
        return calendar.date(from: components)
    }
    
    func set(hour: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.hour = hour
        return calendar.date(from: components)
    }
    
    func set(minute: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.minute = minute
        return calendar.date(from: components)
    }
    
    func set(second: Int, calendar: Calendar = AppConstants.calendar) -> Date? {
        var components = self.getComponents(calendar: calendar)
        components.second = second
        return calendar.date(from: components)
    }
}
