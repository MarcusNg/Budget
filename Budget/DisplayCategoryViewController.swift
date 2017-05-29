//
//  DisplayCategoryViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/24/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit

class DisplayCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryNavBar: UINavigationItem!
    @IBOutlet weak var expenseTable: UITableView!
    
    var category: String?
    var catMoneySpent: Double?
    var catMoneyLimit: Double?
    var catExpenses: [Expense] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        catExpenses = Expenses.queryCategory(category: category!)
        
        self.categoryNavBar.title = category
        self.expenseTable.allowsSelection = false
        self.expenseTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return catExpenses.count
    }
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 96
        } else {
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        // SECTION 1: Budget Bar
        if indexPath.section == 0 {
            
            let moneySpent: String = String(format: "%.02f", catMoneySpent!)
            let moneyLimit: String = String(format: "%.02f", catMoneyLimit!)
            
            let budgetCell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
            budgetCell.categoryLabel.text = ""
            budgetCell.bar.progress = Float(catMoneySpent! / catMoneyLimit!)
            budgetCell.bar.transform = CGAffineTransform(scaleX: 1, y: 8)
            budgetCell.moneyLeftLabel.text = "$\(moneySpent) of $\(moneyLimit)"
            
            cell = budgetCell
            
        } else { // SECTION 2: Expenses
            
            let expenseCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseTableViewCell
            
            let expense = catExpenses[indexPath.row]
            
            let moneySpent: String = String(format: "%.02f", expense.amount)
            
            expenseCell.noteLabel.text = expense.note
            expenseCell.dateLabel.text = DateHelper.printDate(date: expense.date)
            expenseCell.moneySpentLabel.text = "- $\(moneySpent)"
            expenseCell.moneySpentLabel.textColor = UIColor.red
            
            cell = expenseCell

        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
