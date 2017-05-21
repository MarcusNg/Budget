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
    
    static func defaultPopulate() {
        allCategories.append(Category(newCategory: "Clothing", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.blue))
        allCategories.append(Category(newCategory: "Transportation", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.yellow))
        allCategories.append(Category(newCategory: "Other", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.gray))
        allCategories.append(Category(newCategory: "Entertainment", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.green))
        allCategories.append(Category(newCategory: "Food", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.orange))
        allCategories.append(Category(newCategory: "Housing", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.purple))
        allCategories.append(Category(newCategory: "Health", newMoneySpent: 0, newMoneyLimit: 100, newProgress: 0, newColor: UIColor.red))
    }
    
    static func sortByProgress(categories: Array<Category>) -> Array<Category> {
        return categories.sorted { category1,category2 in
            return category1.getProgress() > category2.getProgress()
        }
    }
    
    static func updateMoneySpent(category: String, moneySpent: Double) {
        for cat in allCategories {
            if cat.getCategory() == category {
                let newTotal: Double = cat.getMoneySpent() + moneySpent
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
    
//    // Progress is moneySpent/moneyLimit
//    static func updateProgress(category: String, moneySpent) {
//        for cat in allCategories {
//            if cat.getCategory() == category {
//                cat.setProgress()
//            }
//        }
//    }
    
    static func updateColor(category: String, color: UIColor) {
        for cat in allCategories {
            if cat.getCategory() == category {
                cat.setColor(newColor: color)
            }
        }
    }
    
}
