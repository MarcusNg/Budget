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
    
    dynamic var amount: Int = 0
    dynamic var category: String = ""
    //dynamic var time: ISO8601DateFormatter
    //dynamic var date: Date = Date()
    
}
