//
//  MyCardTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/6/3.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class MyCardTableViewCell: UITableViewCell {

    @IBOutlet weak var headerIv: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var endNoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
