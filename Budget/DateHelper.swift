//
//  DateHelper.swift
//  Budget
//
//  Created by Marcus Ng on 5/9/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class DateHelper {

    static let formatter = DateFormatter()
    
    // Get Month
    static func printMonth(date: Date) -> String {
        formatter.dateFormat = "MMMM"
        
        let month = formatter.string(from: date)
        
        return month
    }
    
    // Get Year
    static func printYear(date: Date) -> String {
        formatter.dateFormat = "yyyy"
        
        let year = formatter.string(from: date)
        
        return year
    }
    
    // Get Month Year
    static func printMonthYear(date: Date) -> String {
        formatter.dateFormat = "MMMM yyyy"
        
        let monthYear = formatter.string(from: date)
        
        return monthYear
    }
    
    // Print Date
    static func printDate(date: Date) -> String {
        formatter.dateFormat = "MMMM dd, yyyy"
        
        let date = formatter.string(from: date)
        
        return date
    }
    
    // Print Time
    static func printTime(date: Date) -> String {
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let time = formatter.string(from: date)
        
        return time
    }
    
}
