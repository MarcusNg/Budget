//
//  CreateExpenseViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/8/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import RealmSwift

class CreateExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let categories = Categories.sortAlphabetically(categories: Categories.allCategories)
    var rotationAngle: CGFloat!
    
    var index: Int = 1
    var costArray: Array<String> = ["$", "0", ".", "0", "0"]
    var cost: Double = 0.00
    var twoTaps: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        expenseAmountLabel.text = "$0.00"
        // Horizontal UIPickerView
        let y = categoryPicker.frame.origin.y
        rotationAngle = -90 * (.pi / 180)
        categoryPicker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        categoryPicker.frame = CGRect(x: -100, y: y, width: view.frame.width + 200, height: 50)
        categoryPicker.selectRow(3, inComponent: 0, animated: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    // Append digit to cost
    @IBAction func numbers(_ sender: UIButton) {
        let num: String = String(sender.tag)
        if index < costArray.count {
            if costArray[index] == "0" { // Replace "0" with num
                costArray[index] = num
                index += 1
                // Don't go over limit
                if index >= costArray.count {
                    index -= 1
                }
            } else if index + 1 < costArray.count && index > costArray.index(of: ".")! && costArray[index] != "0" && costArray[index + 1] == "0" { // Hundredths place
                index += 1
                costArray[index] = num
            } else if costArray.index(of: ".")! < 7 && index < costArray.index(of: ".")! + 1 { // Limit to six figures on the left of the decimal
                costArray.insert(num, at: index)
                index += 1
            }
            getCost()
        }
    }
    
    // Move index to one position past the decimal
    @IBAction func decimal(_ sender: Any) {
        if index < costArray.index(of: ".")! + 1 {
            index = costArray.index(of: ".")! + 1
        }
    }

    // Remove/Replace digit
    @IBAction func backspace(_ sender: Any) {
        if index > costArray.index(of: ".")! + 1 {
            costArray[index] = "0"
            index -= 1
            twoTaps = 0
        } else if index > costArray.index(of: ".")! {
            costArray[index] = "0"
            twoTaps += 1
            if twoTaps == 2 {
                index -= 1
                twoTaps = 0
            }
        } else if index == 2 {
            index -= 1
            costArray[index] = "0"
        } else if index > 1 && index < costArray.index(of: ".")! {
            costArray.remove(at: index)
            index -= 1
        } else if index == costArray.index(of: ".") {
            index -= 1
            costArray.remove(at: index)
        }
        
        if index == 0 {
            index = 1
        }

        getCost()
    }
    
    // Update label and current cost
    func getCost() {
        expenseAmountLabel.text = ""
        var tmp = ""
        for s in 1..<costArray.count {
            tmp += costArray[s]
        }
        cost = Double(tmp)!
        expenseAmountLabel.text! = "$" + tmp
    }
    
    // Adds expense to DB
    func addExpense(category: String, amount: Double, date: Date, note: String) {
        
        let expense = Expense()
        expense.category = category
        expense.amount = amount
        expense.note = note
        expense.date = date
        expense.monthYear = DateHelper.printMonthYear(date: date)
        
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
        addExpense(category: categories[categoryPicker.selectedRow(inComponent: 0)].getCategory(), amount: cost, date: datePicker.date, note: noteTF.text!)
        self.performSegue(withIdentifier: "unwindToBudget", sender: self)
    }
    
    
    // Category Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categories.allCategories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].getCategory() // sort alphabetically
    }
    
    // Width b/c picker view rotated
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 140
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 50))
        
        let categoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 450, height: 50))
        categoryLabel.text = categories[row].getCategory()
        categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightSemibold)
        categoryLabel.textAlignment = .center
        view.addSubview(categoryLabel)
        
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
        return view
    }
    
}
