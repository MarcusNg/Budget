//
//  ExpenseTableViewCell.swift
//  Budget
//
//  Created by Marcus Ng on 5/27/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var moneySpentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
