//
//  BudgetViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/7/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slideMenu()
        //TEMP
        customizeNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Slideout Menu
    func slideMenu() {
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275 // Overlap width
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func RGBFloat(x: Int) -> Float {
        return Float(x) / 255
    }
    
    // Custom Navbar TEMP (put into a static class)
    func customizeNavBar() {
        navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: RGBFloat(x: 255), green: RGBFloat(x: 255), blue: RGBFloat(x: 255), alpha: 1) // Bar Item Tint
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: RGBFloat(x: 51), green: RGBFloat(x: 204), blue: RGBFloat(x: 51), alpha: 1) // NavBar
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Title
    }

}
