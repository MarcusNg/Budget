//
//  BudgetTableViewCell.swift
//  Budget
//
//  Created by Marcus Ng on 5/12/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bar: UIProgressView!
    @IBOutlet weak var moneyLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bar.transform = CGAffineTransform(scaleX: 1, y: 4)
        bar.tintColor = NavBar.RGB(r: 0, g: 204, b: 103)
        bar.backgroundColor = NavBar.RGB(r: 203, g: 202, b: 204)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
