//
//  Expenses.swift
//  Budget
//
//  Created by Marcus Ng on 5/16/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation
import RealmSwift

class Expenses {
    
    static var totalSpent: Double = 0
    
    static let realm = try! Realm()
    
    // Load all expenses
    static func query() {
        print("Query Expenses...")
        
        // Retrieve expenses
        let allExpenses = realm.objects(Expense.self)
        
        for expense in allExpenses {
//            print("Category: \(expense.category) -- Amount: \(expense.amount)")
            
            // Total cost
            totalSpent += expense.amount
            
            // Update money spent
            Categories.updateMoneySpent(category: expense.category, moneySpent: expense.amount)
        }
        
        // TODO: Add time filtering
        
    }
    
    // Get category dates
    static func queryDates(category: String) -> [String] {
        var dates: [String] = []
        print("Query \(category) Dates...")
        
        // Retrieve
        let catExpenses = realm.objects(Expense.self).filter("category = '\(category)'")
        
        for expense in catExpenses {
            if !dates.contains(DateHelper.printDate(date: expense.date)) {
                dates.append(DateHelper.printDate(date: expense.date))
            }
        }
        
        // Sort by time (Most recent)
        let sortedDates = dates.sorted {
            $0.compare($1, options: .numeric) == .orderedDescending
        }
        
        return sortedDates
    }
    

    // Load specific category with dates
    static func queryCategoryDateExpense(category: String) -> [String : [Expense]] {
        var dateExpenses: [String : [Expense]] = [:]
        print("Query \(category) Expenses...")

        let catExpenses = realm.objects(Expense.self).filter("category = '\(category)'")
        
        for expense in catExpenses {
            // If expense array is empty, then add it
            if (dateExpenses[DateHelper.printDate(date: expense.date)] == nil) {
                dateExpenses.updateValue([expense], forKey: DateHelper.printDate(date: expense.date))
            } else { // Update key,value pair
                var expenses: [Expense] = dateExpenses[DateHelper.printDate(date: expense.date)]!
                expenses.append(expense)
                dateExpenses.updateValue(expenses, forKey: DateHelper.printDate(date: expense.date))
            }
        }
        
        return dateExpenses
    }
    
}
