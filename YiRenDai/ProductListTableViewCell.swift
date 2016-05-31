//
//  ProductListTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/4/19.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var shouyiTitleLbl: UILabel!
    @IBOutlet weak var shouyiLbl: UILabel!
    @IBOutlet weak var fengbiqiTitleLbl: UILabel!
    @IBOutlet weak var fengbiqiLbl: UILabel!
    @IBOutlet weak var amountTitleLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
