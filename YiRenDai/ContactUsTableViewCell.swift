//
//  ContactUsTableViewCell.swift
//  YiRenDai
//
//  Created by Rain on 16/5/5.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ContactUsTableViewCell: UITableViewCell {

    //ContactUsCellOne
    @IBOutlet weak var ivOne: UIImageView!
    @IBOutlet weak var nameOne: UILabel!
    @IBOutlet weak var detailOne: UILabel!
    
    
    //ContactUsCellTwo
    @IBOutlet weak var ivTwo: UIImageView!
    @IBOutlet weak var nameTwo: UILabel!
    @IBOutlet weak var detail1Two: UILabel!
    @IBOutlet weak var detail2Two: UILabel!
    
    //ContactUsCellThree
    @IBOutlet weak var ivThree: UIImageView!
    @IBOutlet weak var nameThree: UILabel!
    @IBOutlet weak var detailThree: UICopyLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func tableViewCellWith(tableView: UITableView, indexPath: NSIndexPath) -> ContactUsTableViewCell{
        var identifier = ""
        var index = 0
        switch indexPath.row {
        case 1, 3:
            identifier = "ContactUsCellOne"
            index = 0
        case 2:
            identifier = "ContactUsCellTwo"
            index = 1
        case 0:
            identifier = "ContactUsCellThree"
            index = 2
        default:
            break
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ContactUsTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ContactUsTableViewCell", owner: self, options: nil)[index] as? ContactUsTableViewCell
        }
        return cell!
    }
    
}
