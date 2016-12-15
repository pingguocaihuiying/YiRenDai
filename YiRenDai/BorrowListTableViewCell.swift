//
//  BorrowListTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/8/24.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class BorrowListTableViewCell: UITableViewCell {

    @IBOutlet weak var borrowType: UILabel!
    @IBOutlet weak var borrowMoney: UILabel!
    @IBOutlet weak var borrowTerm: UILabel!
    @IBOutlet weak var borrowState: UILabel!
    @IBOutlet weak var borrowDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        borrowMoney.textColor = UIColor.grayColor()
        borrowTerm.textColor = UIColor.grayColor()
        borrowState.textColor = UIColor.getRedColorFirst()
        borrowDate.textColor = UIColor.grayColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
