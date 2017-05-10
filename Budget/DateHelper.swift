//
//  DateHelper.swift
//  Budget
//
//  Created by Marcus Ng on 5/9/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let date = Date()
    static let calendar = Calendar.current
    
    // Date
    static func getMonth() -> Int {
        let month = calendar.component(.month, from: date)
        return month;
    }
    
    static func getDay() -> Int {
        let day = calendar.component(.day, from: date)
        return day;
    }
    
    static func getYear() -> Int {
        let year = calendar.component(.year, from: date)
        return year;
    }
    
    // Time
    static func getHour() -> Int {
        let hour = calendar.component(.hour, from: date)
        return hour;
    }
    
    static func getMinute() -> Int {
        let minute = calendar.component(.minute, from: date)
        return minute;
    }
    
    static func getSecond() -> Int {
        let second = calendar.component(.second, from: date)
        return second;
    }
    
    // Print Date
    static func printDate() -> String {
        var retDate: String = ""
        retDate += "Date: \(getYear())-\(getMonth())-\(getDay())"
        return retDate
    }
    
    // Print Time
    static func printTime() -> String {
        var retTime: String = ""
        retTime += "Time: \(getHour()):\(getMinute()):\(getSecond())"
        return retTime
    }
    
}
