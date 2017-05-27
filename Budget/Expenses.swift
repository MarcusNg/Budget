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
            print("Category: \(expense.category) -- Amount: \(expense.amount)")
            
            // Total cost
            totalSpent += expense.amount
            
            // Update money spent
            Categories.updateMoneySpent(category: expense.category, moneySpent: expense.amount)
        }
        
        // TODO: Add time filtering
        
    }
    
    // Load specific category
    static func queryCategory(category: String) -> [Expense] {
        var categoryExpenses: [Expense] = []
        print("Query \(category) Expenses...")
        
        // Retrieve
        let catExpenses = realm.objects(Expense.self).filter("category = '\(category)'")
        
        for expense in catExpenses {
            categoryExpenses.append(expense)
        }
        
        return categoryExpenses
    }

    
}
