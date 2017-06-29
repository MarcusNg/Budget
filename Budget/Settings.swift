//
//  Settings.swift
//  Budget
//
//  Created by Marcus Ng on 6/28/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class Settings {
    
    static var clothingMoneyLimit: Double = 200
    static var entertainmentMoneyLimit: Double = 200
    static var foodMoneyLimit: Double = 200
    static var healthMoneyLimit: Double = 200
    static var housingMoneyLimit: Double = 200
    static var otherMoneyLimit: Double = 200
    static var transportationMoneyLimit: Double = 200
    
    static func catMoneyLimit(category: String) -> Double {
        var moneyLimit: Double = 0
        if category == "Clothing" {
            moneyLimit = clothingMoneyLimit
        } else if category == "Entertainment" {
            moneyLimit = entertainmentMoneyLimit
        } else if category == "Food" {
            moneyLimit = foodMoneyLimit
        } else if category == "Health" {
            moneyLimit = healthMoneyLimit
        } else if category == "Housing" {
            moneyLimit = housingMoneyLimit
        } else if category == "Other" {
            moneyLimit = otherMoneyLimit
        } else if category == "Transportation" {
            moneyLimit = transportationMoneyLimit
        }
        return moneyLimit
    }
    
}
