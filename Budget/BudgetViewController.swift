//
//  BudgetViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/7/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit
import RealmSwift
import UICircularProgressRing

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var budgetTable: UITableView!
    @IBOutlet weak var circularProgress: UICircularProgressRingView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation
        slideMenu(button: menuButton)
        NavBar.customizeNavBar(navController: navigationController)
        
        // Visuals
        budgetTable.reloadData()
        progressRing()
        
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
    
    // Progress Ring
    func progressRing() {
        let moneySpent: String = String(format: "%.02f", Categories.totalMoneyLimit - Expenses.totalSpent)
        let moneyLimit: String = String(format: "%.02f", Categories.totalMoneyLimit)
        
        moneyLabel.numberOfLines = 5
        moneyLabel.text = "\(DateHelper.printMonth(date: Date()))\nMoney Left:\n$\(moneySpent)\nof\n$\(moneyLimit)"
        circularProgress.value = CGFloat(Expenses.totalSpent)
        circularProgress.maxValue = CGFloat(Categories.totalMoneyLimit)
        circularProgress.outerRingWidth = 2
        circularProgress.innerRingWidth = 50
        circularProgress.innerRingCapStyle = 1
        circularProgress.shouldShowValueText = false
        circularProgress.showFloatingPoint = true
        circularProgress.decimalPlaces = 2
    }
    
    // Run when segue unwinds
    @IBAction func unwindToBudget(_ segue: UIStoryboardSegue) {
        budgetTable.reloadData()
        progressRing()
        circularProgress.setProgress(value: CGFloat(Expenses.totalSpent), animationDuration: 2.0) {
        }

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
        performSegue(withIdentifier: "displayCategory", sender: self)
    }

}
