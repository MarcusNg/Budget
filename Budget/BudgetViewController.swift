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
    @IBOutlet weak var monthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation
        NavBar.customizeNavBar(navController: navigationController)
        slideMenu(button: menuButton)

//        print("Budget VC Loaded")
    }

    // Updates all categories and budget every time view shows up
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBudget()
//        print("Budget VC Appeared")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Setup VC
    func setup() {
        // Visuals
        monthLabel.text = DateHelper.printMonthYear(date: DateHelper.selectedDate)
        budgetTable.reloadData()
        animateCircleProgress(time: 1.2)
        progressRing()
    }

    // Update
    func updateBudget() {
        Categories.categoryReset()
        setup()
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
        let progress: Double = (Categories.totalMoneyLimit - Expenses.totalSpent) / Categories.totalMoneyLimit
        
        moneyLabel.numberOfLines = 3
        moneyLabel.text = "$\(moneySpent)\nleft of\n$\(moneyLimit)"

        if progress > 0.15 { // Bar turns red 15%-
            circularProgress.innerRingColor = NavBar.RGB(r: 0, g: 204, b: 103)
        } else {
            circularProgress.innerRingColor = UIColor.red
        }
        
        circularProgress.startAngle = -90
        
        circularProgress.innerRingSpacing = 0
        
        circularProgress.outerRingColor = UIColor.lightGray
        
        circularProgress.value = CGFloat(Categories.totalMoneyLimit - Expenses.totalSpent)
        circularProgress.maxValue = CGFloat(Categories.totalMoneyLimit)
        
        circularProgress.outerRingWidth = 4
        circularProgress.innerRingWidth = 25
        
        circularProgress.outerRingCapStyle = 1
        circularProgress.innerRingCapStyle = 1
        
        circularProgress.shouldShowValueText = false
    }
    
    // Animate progress circle
    func animateCircleProgress(time: Double) {
        circularProgress.setProgress(value: CGFloat(Categories.totalMoneyLimit - Expenses.totalSpent), animationDuration: time) {
        }
    }
    
    // Run when segue unwinds
    @IBAction func unwindToBudget(_ segue: UIStoryboardSegue) {
        print("Unwind to BudgetVC")
        DateHelper.selectedDate = Date()
        updateBudget()
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
    
    // Previous Month Button
    @IBAction func prevMonthButton(_ sender: Any) {
        DateHelper.prevMonth()
        updateBudget()
    }
    
    // Next Month Button
    @IBAction func nextMonthButton(_ sender: Any) {
        DateHelper.nextMonth()
        updateBudget()
    }
    
    
    // Table View -- sort by highest progress
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return Categories.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell", for: indexPath) as! BudgetTableViewCell
        
        let category = Categories.sortByProgress(categories: Categories.allCategories)[indexPath.row]
        let moneySpent: String = String(format: "%.02f", category.getMoneySpent())
        let moneyLimit: String = String(format: "%.02f", category.getMoneyLimit())
        
        cell.categoryLabel.text = category.getCategory() // Category
        
        UIView.animate(withDuration: 1.2, animations: { () -> Void in
            cell.bar.setProgress(Float(category.getProgress()), animated: true)
        })
        if cell.bar.progress >= 0.85 { // +85% red
            cell.bar.tintColor = UIColor.red
        } else {
            cell.bar.tintColor = NavBar.RGB(r: 0, g: 204, b: 103)
        }
        cell.moneyLeftLabel.text = "$" + moneySpent + " of $" + moneyLimit // $ of $
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "displayCategory", sender: self)
    }

}
