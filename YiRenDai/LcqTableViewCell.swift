//
//  LcqTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/4/21.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class LcqTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var typeIv: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var imageIv: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
