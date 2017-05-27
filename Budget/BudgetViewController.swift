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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation
        slideMenu(button: menuButton)
        NavBar.customizeNavBar(navController: navigationController)
        
        // Visuals
        setPieChart()
        budgetTable.reloadData()
        
        print("Budget VC Loaded")
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
    
    // Pie Chart
    func setPieChart() {
        print("Create Pie Chart...")
        var entries: [PieChartDataEntry] = []
        
//         Add each categoryTotal values to the PieChartDataEntries
        for cat in Categories.allCategories {
            if cat.getMoneySpent() != 0 {
                entries.append(PieChartDataEntry(value: cat.getMoneySpent(), label: ""))
            }
        }
        
        
        let set: PieChartDataSet = PieChartDataSet(values: entries, label: "Budget")
        
        // ------Colors------
        var colors: [UIColor] = []
        
        for cat in Categories.allCategories {
            colors.append(NavBar.RGB(r: Int(arc4random_uniform(256)), g: Int(arc4random_uniform(256)), b: Int(arc4random_uniform(256))))
        }
        
        set.colors = colors
//         ------------------

        
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
    
    // Run when segue unwinds
    @IBAction func unwindToBudget(_ segue: UIStoryboardSegue) {
        setPieChart()
        budgetTable.reloadData()
    }
    
    // Segue to category
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayCategory" {
                
                // Find row selected
                let indexPath = self.budgetTable.indexPathForSelectedRow!
                let displayCategoryVC = segue.destination as! DisplayCategoryViewController
                
                // Pass the category to the displayVC
                let sortedCat = Categories.sortByProgress(categories: Categories.allCategories)[indexPath.row]
                displayCategoryVC.category = sortedCat.getCategory()
                displayCategoryVC.catMoneySpent = sortedCat.getMoneySpent()
                displayCategoryVC.catMoneyLimit = sortedCat.getMoneyLimit()
                // Deselect cell
                budgetTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    // Table View -- sort by most highest progress
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return Categories.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
        
        let category = Categories.sortByProgress(categories: Categories.allCategories)[indexPath.row]
        let moneySpent: String = String(format: "%.02f", category.getMoneySpent())
        let moneyLimit: String = String(format: "%.02f", category.getMoneyLimit())
        
        cell.categoryLabel.text = category.getCategory() // Category
        cell.bar.progress = Float(category.getProgress())
        cell.moneyLeftLabel.text = "$" + moneySpent + " of $" + moneyLimit // $ of $

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        // Bring to list of previous category purchases for that month
//        print("Tapped \(indexPath)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
        performSegue(withIdentifier: "displayCategory", sender: self)

        //print(Categories.allCategories[indexPath.row].getCategory())
    }

}
