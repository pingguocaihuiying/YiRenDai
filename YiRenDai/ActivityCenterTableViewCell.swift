//
//  ActivityCenterTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/4/23.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ActivityCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var imageIv: UIImageView!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var lickLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLbl.textColor = UIColor.lightGrayColor()
        //lineView
        let lineView = UIView(frame: CGRectMake(0, detailLbl.viewBottomY + 10, screen_width, 0.5))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(lineView)
        detailLbl.textColor = UIColor.lightGrayColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
