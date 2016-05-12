//
//  ManageTeamTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ManageTeamTableViewCell: UITableViewCell {
    @IBOutlet weak var headIv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var positionLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var moreDetailTv: UITextView!
    @IBOutlet weak var moreIv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moreDetailTv.scrollEnabled = false
        moreDetailTv.editable = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
