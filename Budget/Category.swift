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
    private var color: UIColor
    
    // Default constructor
    init() {
        category = "NO CATEGORY"
        moneySpent = 0
        moneyLimit = 0
        progress = 0
        color = UIColor.red
    }
    
    // Overloaded constructor
    init(newCategory: String, newMoneySpent: Double, newMoneyLimit: Double, newProgress: Double, newColor: UIColor) {
        category = newCategory
        moneySpent = newMoneySpent
        moneyLimit = newMoneyLimit
        progress = newProgress
        color = newColor
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
    
    func getColor() -> UIColor {
        return color
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
    
    func setColor(newColor: UIColor) {
        color = newColor
    }
    
    // Update
    func updateProgress() {
        progress = moneySpent / moneyLimit // round?
    }
    
}
