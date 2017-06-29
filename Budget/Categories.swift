//
//  Categories.swift
//  Budget
//
//  Created by Marcus Ng on 5/15/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation
import RealmSwift

class Categories {
    
    static let realm = try! Realm()
    static var totalMoneyLimit: Double = 0
    static var allCategories = realm.objects(Category.self).filter("monthYear = '\(DateHelper.printMonthYear(date: Date()))'")
    
    static var categoryNames: [String] = ["Clothing", "Entertainment", "Food", "Health", "Housing", "Other", "Transportation"]
    
    static func defaultPopulate() {
        // Runs if new month or first time launching app
        if allCategories.isEmpty {
            for catName in categoryNames {
                // Create category
                let category = Category()
                category.name = catName
                category.moneySpent = 0
                category.moneyLimit = 200
                category.progress = 0
                
                try! realm.write {
                    realm.add(category)
                }
            }
        } else {
            for cat in allCategories {
                try! realm.write {
                    realm.create(Category.self, value: ["id": cat.id, "moneySpent": 0, "moneyLimit": Settings.catMoneyLimit(category: cat.name) /*FILTER FOR SPECIFIC CATEGORY WITH CORRECT MONTHYEAR TO FIND THE MONEY LIMIT!!!*/, "progress": 0], update: true)

                }
            }
        }
    }
    
    static func updateAllCategories() {
        totalMoneyLimit = 0
        for cat in allCategories {
            // Total money limit
            totalMoneyLimit += cat.moneyLimit
            // Update each category
            let newProgress: Double = cat.moneySpent / Settings.catMoneyLimit(category: cat.name)
            
            try! realm.write {
                realm.create(Category.self, value: ["id": cat.id, "moneyLimit": Settings.catMoneyLimit(category: cat.name) /*FILTER FOR SPECIFIC CATEGORY WITH CORRECT MONTHYEAR TO FIND THE MONEY LIMIT!!!*/, "progress": newProgress], update: true)
            }
        }
    }
    
    static func updateCategory(category: String, moneySpent: Double, oldMoneySpent: Double) {
        for cat in allCategories {
            if category == cat.name {
                let newTotal: Double = abs(cat.moneySpent + moneySpent - oldMoneySpent)
                let newProgress: Double = newTotal / Settings.catMoneyLimit(category: cat.name)
                if !realm.isInWriteTransaction {
                    try! realm.write {
                        realm.create(Category.self, value: ["id": cat.id, "moneySpent": newTotal, "moneyLimit": Settings.catMoneyLimit(category: cat.name), "progress": newProgress], update: true)
                    }
                } else {
                    realm.create(Category.self, value: ["id": cat.id, "moneySpent": newTotal, "moneyLimit": Settings.catMoneyLimit(category: cat.name), "progress": newProgress], update: true)
                }
            }
        }
    }
    
    static func categoryReset() {
        allCategories = realm.objects(Category.self).filter("monthYear = '\(DateHelper.printMonthYear(date: DateHelper.selectedDate))'")
        defaultPopulate()
        updateAllCategories()
        Expenses.queryMonth(monthYear: DateHelper.printMonthYear(date: DateHelper.selectedDate))
    }
    
//    static func sortByProgress(categories: Array<Category>) -> Array<Category> {
//        return categories.sorted { category1,category2 in
//            return category1.getProgress() > category2.getProgress()
//        }
//    }
//    
//    static func sortAlphabetically(categories: Array<Category>) -> Array<Category> {
//        return categories.sorted { category1,category2 in
//            return category1.getCategory() < category2.getCategory()
//        }
//    }
//    
//    static func updateMoneySpent(category: String, moneySpent: Double, oldMoneySpent: Double) {
//        for cat in allCategories {
//            if cat.getCategory() == category {
//                var newTotal: Double = cat.getMoneySpent() + moneySpent - oldMoneySpent
//                
//                if newTotal < 0 {
//                    newTotal = abs(newTotal)
//                }
//                
//                cat.setMoneySpent(newMoneySpent: newTotal)
//                cat.setProgress(newProgress: newTotal / cat.getMoneyLimit())
//            }
//        }
//    }
//    
//    static func updateMoneyLimit(category: String, moneyLimit: Double) {
//        for cat in allCategories {
//            if cat.getCategory() == category {
//                cat.setMoneyLimit(newMoneyLimit: moneyLimit)
//            }
//        }
//    }
//    
//    static func calcTotalMoneyLimit() {
//        totalMoneyLimit = 0
//        for cat in allCategories {
//            totalMoneyLimit += cat.getMoneyLimit()
//        }
//    }
//    
//    static func categoryReset() {
//        Categories.defaultPopulate()
//        Categories.calcTotalMoneyLimit()
//        Expenses.queryMonth(monthYear: DateHelper.printMonthYear(date: DateHelper.selectedDate))
//    }
    
}
