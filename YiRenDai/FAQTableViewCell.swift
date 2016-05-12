//
//  FAQTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    //CellIdentifierFirst
    @IBOutlet weak var firstTitleLbl: UILabel!
    //CellIdentifierSecond
    @IBOutlet weak var secondTitleLbl: UILabel!
    @IBOutlet weak var secondDetail1Lbl: UILabel!
    @IBOutlet weak var secondDetail2Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func tableViewCellWith(tableView: UITableView, indexPath: NSIndexPath) -> FAQTableViewCell{
        var identifier = ""
        var index = 0
        if indexPath.section == 0 {
            identifier = "FAQCellFirst"
            index = 0
        }else if indexPath.section == 1{
            identifier = "FAQCellSecond"
            index = 1
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? FAQTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FAQTableViewCell", owner: self, options: nil)[index] as? FAQTableViewCell
        }
        return cell!
    }
    
}
