//
//  DisplayCategoryViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/24/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryNavBar: UINavigationItem!
    @IBOutlet weak var expenseTable: UITableView!
    
    var category: String?
    var catMoneySpent: Double?
    var catMoneyLimit: Double?
    var dates: [String] = [] // Array of dates from expenses (current month)
    var dateExpenses: [String : [Expense]] = [:] // Contain dates paired with matching expenses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dates = Expenses.queryDates(category: category!, monthYear: DateHelper.printMonthYear(date: DateHelper.selectedDate))
        dateExpenses = Expenses.queryCategoryDateExpense(category: category!, monthYear: DateHelper.printMonthYear(date: DateHelper.selectedDate))
        
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
            
            let budgetCell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
            
            let moneySpent: String = String(format: "%.02f", catMoneySpent!)
            let moneyLimit: String = String(format: "%.02f", catMoneyLimit!)
            
            budgetCell.categoryLabel.text = ""

//            budgetCell.bar.transform = CGAffineTransform(scaleX: 1, y: 8)
            let progress: Float = Float(self.catMoneySpent! / self.catMoneyLimit!)
            // Bug - doesn't fill whole bar height)
            UIView.animate(withDuration: 1.2, animations: { () -> Void in
                budgetCell.bar.setProgress(progress, animated: true)
            })
          
            budgetCell.bar.progress = progress
            
            if budgetCell.bar.progress >= 0.85 { //+85% red
                budgetCell.bar.tintColor = UIColor.red
            } else {
                budgetCell.bar.tintColor = NavBar.RGB(r: 0, g: 204, b: 103)
            }
            
            budgetCell.moneyLeftLabel.text = "$\(moneySpent) of $\(moneyLimit)"
            
            budgetCell.selectionStyle = UITableViewCellSelectionStyle.none
            budgetCell.isUserInteractionEnabled = false
            
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
    
    // Table View Actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            print("Edit cell")
        }
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, index) in
            print("Delete cell")
            
            // Get remove expense from dictionary
            let expense = self.dateExpenses[self.dates[indexPath.section - 1]]?.remove(at: indexPath.row)
            self.catMoneySpent = self.catMoneySpent! - (expense?.amount)!
            
            // Remove date if no expenses
            if (self.dateExpenses[self.dates[indexPath.section - 1]]?.isEmpty)! {
                self.dates.remove(at: indexPath.section - 1)
            }
            
            // Delete from realm
            let realm = try! Realm()
            try! realm.write {
                realm.delete(expense!)
            }
            tableView.reloadData()
        }
        
        editAction.backgroundColor = UIColor.lightGray
        
        return [deleteAction, editAction]
    }
    

}
