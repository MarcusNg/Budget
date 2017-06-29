//
//  Cateogyr.swift
//  Budget
//
//  Created by Marcus Ng on 5/14/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    dynamic var id: String = UUID().uuidString
    dynamic var name: String = ""
    dynamic var moneySpent: Double = 0
    dynamic var moneyLimit: Double = 0
    dynamic var progress: Double = 0
    dynamic var monthYear: String = DateHelper.printMonthYear(date: DateHelper.selectedDate)
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    // Default constructor
//    init() {
//        category = "CATEGORY"
//        moneySpent = 0
//        moneyLimit = 0
//        progress = 0
//    }
//    
//    // Overloaded constructor
//    init(newCategory: String, newMoneySpent: Double, newMoneyLimit: Double, newProgress: Double) {
//        category = newCategory
//        moneySpent = newMoneySpent
//        moneyLimit = newMoneyLimit
//        progress = newProgress
//    }
//    
//    // Getters
//    func getCategory() -> String {
//        return category
//    }
//    
//    func getMoneySpent() -> Double {
//        return moneySpent
//    }
//    
//    func getMoneyLimit() -> Double {
//        return moneyLimit
//    }
//    
//    func getProgress() -> Double {
//        return progress
//    }
//    
//    // Setters
//    func setCategory(newCategory: String) {
//        category = newCategory
//    }
//    
//    func setMoneySpent(newMoneySpent: Double) {
//        moneySpent = newMoneySpent
//    }
//    
//    func setMoneyLimit(newMoneyLimit: Double) {
//        moneyLimit = newMoneyLimit
//    }
//    
//    func setProgress(newProgress: Double) {
//        progress = newProgress
//    }
//    
//    // Update
//    func updateProgress() {
//        progress = moneySpent / moneyLimit
//    }
    
}
