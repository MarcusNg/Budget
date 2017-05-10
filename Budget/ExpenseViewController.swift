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

    @IBOutlet weak var expenseAmountTF: UITextField!
    
    @IBOutlet weak var categoryTF: UITextField!
    
    // categories array
//    let categories: [String] = ["Business", "Entertainment", "General", "Pets"]
//    let expenses: [Expense] =
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds expense to DB
    func addExpense(amount: Double, category: String) {
        
        let expense = Expense()
        expense.amount = amount
        expense.category = category
        //expense.date = ...
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(expense)
            print("Added: " + expense.category + " -- " + String(expense.amount))
            
            // Time test
            print(DateHelper.printDate())
            print(DateHelper.printTime())
        }
        
    }
    
    
    @IBAction func addExpenseButton(_ sender: Any) {
        addExpense(amount: Double(expenseAmountTF.text!)!, category: categoryTF.text!)
        self.performSegue(withIdentifier: "unwindToBudget", sender: self)
    }

}
