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
        self.expenseTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        // Budget Bar
        if (indexPath.row == 0) {
            
            let moneySpent: String = String(format: "%.02f", catMoneySpent!)
            let moneyLimit: String = String(format: "%.02f", catMoneyLimit!)
            
            let budgetCell = expenseTable.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
            budgetCell.categoryLabel.text = ""
            budgetCell.bar.progress = Float(catMoneySpent! / catMoneyLimit!)
            budgetCell.bar.transform = CGAffineTransform(scaleX: 1, y: 6)
            budgetCell.moneyLeftLabel.text = "$\(moneySpent) of $\(moneyLimit)"
            
            cell = budgetCell
            
        } else { // Expenses
            
            let expenseCell = expenseTable.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseTableViewCell
            
            let expense = catExpenses[indexPath.row]
            
            let moneySpent: String = String(format: "%.02f", expense.amount)
            
            expenseCell.descriptionLabel.text = "Note..."
            expenseCell.dateLabel.text = "Date..."
            expenseCell.moneySpentLabel.text = "- $\(moneySpent)"
            expenseCell.moneySpentLabel.textColor = UIColor.red
            
            cell = expenseCell

        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expenseTable.deselectRow(at: indexPath, animated: true)
    }

}
