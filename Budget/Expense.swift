//
//  Expense.swift
//  Budget
//
//  Created by Marcus Ng on 5/8/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation
import RealmSwift

class Expense: Object {
    
    dynamic var id: String = UUID().uuidString
    dynamic var category: String = ""
    dynamic var amount: Double = 0
    dynamic var date: Date = Date()
    dynamic var note: String = ""
    dynamic var monthYear: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
