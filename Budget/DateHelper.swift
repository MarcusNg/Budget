//
//  DateHelper.swift
//  Budget
//
//  Created by Marcus Ng on 5/9/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let calendar = Calendar.current
    
    // Date
    static func getMonth(date: Date) -> Int {
        let month = calendar.component(.month, from: date)
        return month;
    }
    
    static func getDay(date: Date) -> Int {
        let day = calendar.component(.day, from: date)
        return day;
    }
    
    static func getYear(date: Date) -> Int {
        let year = calendar.component(.year, from: date)
        return year;
    }
    
    // Time
    static func getHour(date: Date) -> Int {
        let hour = calendar.component(.hour, from: date)
        return hour;
    }
    
    static func getMinute(date: Date) -> Int {
        let minute = calendar.component(.minute, from: date)
        return minute;
    }
    
    static func getSecond(date: Date) -> Int {
        let second = calendar.component(.second, from: date)
        return second;
    }
    
    // Print Date
    static func printDate(date: Date) -> String {
        var retDate: String = ""
        retDate += "\(getYear(date: date))-\(getMonth(date: date))-\(getDay(date: date))"
        return retDate
    }
    
    // Print Time
    static func printTime(date: Date) -> String {
        var retTime: String = ""
        retTime += "\(getHour(date: date)):\(getMinute(date: date)):\(getSecond(date: date))"
        return retTime
    }
    
}
