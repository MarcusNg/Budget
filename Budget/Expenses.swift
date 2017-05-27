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
    
    static var expenses: [Expense] = []
    static var totalSpent: Double = 0
    
    // Load expenses
    static func query() {
        print("Query Expenses...")
        let realm = try! Realm()
        
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

    
}
