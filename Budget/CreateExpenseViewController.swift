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
    
    @IBOutlet weak var expenseAmountTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    
    let categories = Categories.sortAlphabetically(categories: Categories.allCategories)
    
    var rotationAngle: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // Adds expense to DB
    func addExpense(category: String, amount: Double, note: String) {
        
        let expense = Expense()
        expense.category = category
        expense.amount = amount
        expense.note = note
        expense.date = Date()
        expense.monthYear = DateHelper.printMonthYear(date: Date())
        
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
        addExpense(category: categories[categoryPicker.selectedRow(inComponent: 0)].getCategory(), amount: Double(expenseAmountTF.text!)!, note: noteTF.text!)
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
