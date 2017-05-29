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
    
    // Print Date
    static func printDate(date: Date) -> String {
        formatter.dateFormat = "MMMM dd, yyyy"
        
        let date = formatter.string(from: date)
        
        return date  // "4:44 PM on June 23, 2016\n"
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
