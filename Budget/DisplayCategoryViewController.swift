//
//  DisplayCategoryViewController.swift
//  Budget
//
//  Created by Marcus Ng on 5/24/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit

class DisplayCategoryViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.categoryLabel.text = category
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
