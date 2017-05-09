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
    
    
    let categories: [String] = ["Business", "Entertainment", "General", "Pets"]
    let expenses: [Int] = [100, 150, 50, 25]
        
        
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
        
        let realm = try! Realm()
        
        let allExpenses = realm.objects(Expense.self)
        
//        var business = allExpenses.filter("category")
        
        for expense in allExpenses {
            print("Category: \(expense.category)" + " Amount: " + String(expense.amount))
        }
        
    }
    
    // Pie Chart
    func setPieChart() {
        
        var entries: [PieChartDataEntry] = []
        
        entries.append(PieChartDataEntry(value: 25.5, label: "Business"))
        entries.append(PieChartDataEntry(value: 100.5, label: "Entertainment"))
        entries.append(PieChartDataEntry(value: 54, label: "General"))
        entries.append(PieChartDataEntry(value: 6.5, label: "Food"))
        
        let set: PieChartDataSet = PieChartDataSet(values: entries, label: "Budget")
        
        // ------Colors------
        var colors: [UIColor] = []
        
        for i in 0...4 {
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
    
}
