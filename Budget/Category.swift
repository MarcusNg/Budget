//
//  Cateogyr.swift
//  Budget
//
//  Created by Marcus Ng on 5/14/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class Category {
    
    private var category: String;
    private var moneySpent: Double
    private var moneyLimit: Double
    private var progress: Double
    
    // Default constructor
    init() {
        category = "CATEGORY"
        moneySpent = 0
        moneyLimit = 0
        progress = 0
    }
    
    // Overloaded constructor
    init(newCategory: String, newMoneySpent: Double, newMoneyLimit: Double, newProgress: Double) {
        category = newCategory
        moneySpent = newMoneySpent
        moneyLimit = newMoneyLimit
        progress = newProgress
    }
    
    // Getters
    func getCategory() -> String {
        return category
    }
    
    func getMoneySpent() -> Double {
        return moneySpent
    }
    
    func getMoneyLimit() -> Double {
        return moneyLimit
    }
    
    func getProgress() -> Double {
        return progress
    }
    
    // Setters
    func setCategory(newCategory: String) {
        category = newCategory
    }
    
    func setMoneySpent(newMoneySpent: Double) {
        moneySpent = newMoneySpent
    }
    
    func setMoneyLimit(newMoneyLimit: Double) {
        moneyLimit = newMoneyLimit
    }
    
    func setProgress(newProgress: Double) {
        progress = newProgress
    }
    
    // Update
    func updateProgress() {
        progress = moneySpent / moneyLimit
    }
    
}
