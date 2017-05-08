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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addExpense()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addExpense(/*amount: Int, category[]*/) {
        
        let expense = Expense()
        expense.amount = 100
        expense.category = "Business"
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(expense)
            print("Added: " + expense.category + " -- " + String(expense.amount))
        }
        
    }

}
