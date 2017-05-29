//
//  CreateExpenseViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/8/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import RealmSwift

class CreateExpenseViewController: UIViewController {

    @IBOutlet weak var expenseAmountTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds expense to DB
    func addExpense(category: String, amount: Double, note: String) {
        
        let expense = Expense()
        expense.category = category
        expense.amount = amount
        expense.note = note
        expense.date = Date()
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(expense)
//            print("Added: " + expense.category + " -- " + String(expense.amount))
            
            // Update money spent
            Categories.updateMoneySpent(category: expense.category, moneySpent: expense.amount)

            // Update total expenses
            Expenses.totalSpent += expense.amount

//            print(expense.date)
        }
        
    }
    
    
    @IBAction func addExpenseButton(_ sender: Any) {
        addExpense(category: categoryTF.text!, amount: Double(expenseAmountTF.text!)!, note: noteTF.text!)
        self.performSegue(withIdentifier: "unwindToBudget", sender: self)
    }

}
