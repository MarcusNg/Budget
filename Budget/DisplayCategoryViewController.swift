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
    var dates: [String] = []
    var dateExpenses: [String : [Expense]] = [:] // Contain dates paired with matching expenses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dates = Expenses.queryDates(category: category!)
        dateExpenses = Expenses.queryCategoryDateExpense(category: category!)
        
        for date in dates {
            let dateExp = dateExpenses[date]?.sorted {
                $0.date > $1.date
            }
            
            dateExpenses[date] = dateExp
        }
        
        self.categoryNavBar.title = category
        self.expenseTable.allowsSelection = false
        self.expenseTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dateExpenses[dates[section - 1]]!.count
    }
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 96
        } else {
            return 72
        }
    }
    
    // Section Header Title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        return dates[section - 1]
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

            let expense = dateExpenses[dates[indexPath.section - 1]]?[indexPath.row]
            
            let moneySpent: String = String(format: "%.02f", expense!.amount)
            
            expenseCell.noteLabel.text = expense!.note
            expenseCell.timeLabel.text = DateHelper.printTime(date: expense!.date)
            expenseCell.moneySpentLabel.text = "- $\(moneySpent)"
            expenseCell.moneySpentLabel.textColor = UIColor.red
            
            cell = expenseCell

        }
        
        return cell
    }

}
