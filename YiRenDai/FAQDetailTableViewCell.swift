//
//  FAQDetailTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class FAQDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var stateIv: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func tableViewCellWith(tableView: UITableView, indexPath: NSIndexPath) -> FAQDetailTableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("FAQDetailCell") as? FAQDetailTableViewCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("FAQDetailTableViewCell", owner: self, options: nil)[0] as? FAQDetailTableViewCell
            if indexPath.row % 2 != 0 {
                cell?.titleLbl.textColor = UIColor.grayColor()
                cell?.titleLbl.font = UIFont.systemFontOfSize(14)
            }else{
                cell?.titleLbl.font = UIFont.systemFontOfSize(16)
            }
        }
        return cell!
    }
    
}
