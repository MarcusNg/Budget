//
//  BudgetViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/7/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class BudgetViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    // Temporary
    let categories: [String] = ["Business", "Clothing", "Education", "Electronics", "Entertainment", "Food", "General", "Gifts", "Health", "Home", "Kids", "Personal", "Pets", "Transportation", "Utilities", "Vacation"]
    
    var expenses: [Expense] = []
    var categoryTotal: [String: Double] = ["Business": 0, "Clothing": 0, "Education": 0,"Electronics": 0, "Entertainment": 0, "Food": 0, "General": 0, "Gifts": 0, "Health": 0, "Home": 0, "Kids": 0, "Personal": 0, "Pets": 0, "Transportation": 0, "Utilities": 0, "Vacation": 0]
    var totalSpent: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        slideMenu(button: menuButton)
        NavBar.customizeNavBar(navController: navigationController)
        queryExpenses()
        
        setPieChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Slideout Menu
    func slideMenu(button: UIBarButtonItem) {
        
        if revealViewController() != nil {
            
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = screenWidth * 0.7 // Overlap width
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
        }
    }
    
    // Load expenses
    func queryExpenses() {
        print("Query Expenses...")
        let realm = try! Realm()
        
        let allExpenses = realm.objects(Expense.self)
        
        for expense in allExpenses {
            print("Category: \(expense.category)" + "\nAmount: " + String(expense.amount))
            expenses.append(expense) // Add expense to expenses array
            
            // Total cost
            totalSpent += expense.amount
            
            // Add expense amount to the corresponding category
            var newTotal: Double = categoryTotal[expense.category]!
            newTotal += expense.amount
            categoryTotal.updateValue(newTotal, forKey: expense.category)
        }
        
        // TODO: Get totals for each category and then add the percentage values to the pie chart
        // Also have to add time filtering
        
    }
    
    // Pie Chart
    func setPieChart() {
        print("Create Pie Chart...")
        var entries: [PieChartDataEntry] = []
        
        // Add each categoryTotal values to the PieChartDataEntries
        for (category, totalSpent) in categoryTotal {
            print(category + ": $" + String(totalSpent))
            if totalSpent != 0 {
                
                // Get percent
                
                entries.append(PieChartDataEntry(value: totalSpent, label: category))
            }
        }
        
        let set: PieChartDataSet = PieChartDataSet(values: entries, label: "Budget")
        
        // ------Colors------
        var colors: [UIColor] = []
        
        for _ in 0...4 {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        set.colors = colors
        // ------------------
        
        let data: PieChartData = PieChartData(dataSet: set)
        
        pieChartView.data = data
        
        // Description
        pieChartView.chartDescription?.text = ""
        
        // Disable Legend
        let legend: Legend = pieChartView.legend
        legend.enabled = false
        
        pieChartView.invalidateIntrinsicContentSize()
        
    }
    
    // Print categoryTotal dictionary
    func printExpenseDictionary() {
        
    }
}
