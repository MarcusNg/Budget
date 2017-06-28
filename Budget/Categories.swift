//
//  Categories.swift
//  Budget
//
//  Created by Marcus Ng on 5/15/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class Categories {
    
    // Sorting by progress, money spent, alphabetical
    // Hide categories that have no money spent?
    // Clothing, Entertainment, Food, Health, Housing, Other, Transportation

    static var allCategories: [Category] = []
    static var totalMoneyLimit: Double = 0
    
    static func defaultPopulate() {
        // Set categories to empty
        allCategories = []
        
        // Add categories
        allCategories.append(Category(newCategory: "Clothing", newMoneySpent: 0, newMoneyLimit: Settings.clothingMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Entertainment", newMoneySpent: 0, newMoneyLimit: Settings.entertainmentMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Food", newMoneySpent: 0, newMoneyLimit: Settings.foodMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Health", newMoneySpent: 0, newMoneyLimit: Settings.healthMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Housing", newMoneySpent: 0, newMoneyLimit: Settings.housingMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Other", newMoneySpent: 0, newMoneyLimit: Settings.otherMoneyLimit, newProgress: 0))
        allCategories.append(Category(newCategory: "Transportation", newMoneySpent: 0, newMoneyLimit: Settings.transportationMoneyLimit, newProgress: 0))
        
    }
    
    static func sortByProgress(categories: Array<Category>) -> Array<Category> {
        return categories.sorted { category1,category2 in
            return category1.getProgress() > category2.getProgress()
        }
    }
    
    static func sortAlphabetically(categories: Array<Category>) -> Array<Category> {
        return categories.sorted { category1,category2 in
            return category1.getCategory() < category2.getCategory()
        }
    }
    
    static func updateMoneySpent(category: String, moneySpent: Double, oldMoneySpent: Double) {
        for cat in allCategories {
            if cat.getCategory() == category {
                var newTotal: Double = cat.getMoneySpent() + moneySpent - oldMoneySpent
                
                if newTotal < 0 {
                    newTotal = abs(newTotal)
                }
                
                cat.setMoneySpent(newMoneySpent: newTotal)
                cat.setProgress(newProgress: newTotal / cat.getMoneyLimit())
            }
        }
    }
    
    static func updateMoneyLimit(category: String, moneyLimit: Double) {
        for cat in allCategories {
            if cat.getCategory() == category {
                cat.setMoneyLimit(newMoneyLimit: moneyLimit)
            }
        }
    }
    
    static func calcTotalMoneyLimit() {
        totalMoneyLimit = 0
        for cat in allCategories {
            totalMoneyLimit += cat.getMoneyLimit()
        }
    }
    
    static func categoryReset() {
        Categories.defaultPopulate()
        Categories.calcTotalMoneyLimit()
        Expenses.queryMonth(monthYear: DateHelper.printMonthYear(date: DateHelper.selectedDate))
    }
    
}
