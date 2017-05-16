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

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var budgetTable: UITableView!
    
    var expenses: [Expense] = []
    
    var totalSpent: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation
        slideMenu(button: menuButton)
        NavBar.customizeNavBar(navController: navigationController)
        
        // Setup expenses and categories
        Categories.defaultPopulate()
        queryExpenses()
        
        // Visuals
        setPieChart()
        budgetTable.reloadData()
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
            
            // Total cost
            totalSpent += expense.amount
 
            // Update money spent
            Categories.updateMoneySpent(category: expense.category, moneySpent: expense.amount)
        }
        
        // TODO: Add time filtering
        
    }
    
    // Pie Chart
    func setPieChart() {
        print("Create Pie Chart...")
        var entries: [PieChartDataEntry] = []
        
        // Add each categoryTotal values to the PieChartDataEntries
        for category in Categories.allCategories {
            if category.getMoneySpent() != 0 {
                entries.append(PieChartDataEntry(value: category.getMoneySpent(), label: ""))
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
        
        // Center text
        pieChartView.centerText = "%"
        
        // No data text
        pieChartView.noDataText = "Please enter an expense"
        
        // Description
        pieChartView.chartDescription?.text = ""
        
        // % Values
        pieChartView.usePercentValuesEnabled = true;
        
        // Disable Legend
        let legend: Legend = pieChartView.legend
        legend.enabled = false
        
        // Refresh chart
        pieChartView.invalidateIntrinsicContentSize()
        
    }
    
    // Table View -- sort by most highest progress
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return Categories.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
        
        let category = Categories.allCategories[indexPath.row]
        let money: String = String(format: "%.02f", category.getMoneySpent())
        
        cell.categoryLabel.text = Categories.allCategories[indexPath.row].getCategory() // Category
        cell.bar.progress = Float(arc4random()) / Float(UINT32_MAX)// Decimal percent, spent/budget //categories[indexPath.row].getProgress()//
        cell.moneyLeftLabel.text = "$" + money + " of " + "$$$" // $ of $

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Bring to list of previous category purchases for that month
        print("Tapped \(indexPath)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell

        print(Categories.allCategories[indexPath.row].getCategory())
    }
}
