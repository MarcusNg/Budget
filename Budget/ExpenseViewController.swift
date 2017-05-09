//
//  ExpenseViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/8/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import RealmSwift

class ExpenseViewController: UIViewController {

    // categories array
//    let categories: [String] = ["Business", "Entertainment", "General", "Pets"]
//    let expenses: [Expense] =
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addExpense()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds expense to DB
    func addExpense(/*amount: Int, category[]*/) {
        
        let expense = Expense()
        expense.amount = 50
        expense.category = "Entertainment"
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(expense)
            print("Added: " + expense.category + " -- " + String(expense.amount))
        }
        
    }

}
