//
//  UICopyLabel.swift
//  YiRenDai
//
//  Created by Rain on 16/5/6.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class UICopyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit(){
        userInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMenu(_:))))
    }
    
    func showMenu(sender: AnyObject?){
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        if !menu.menuVisible{
            menu.setTargetRect(bounds, inView: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func copy(sender: AnyObject?) {
        let board = UIPasteboard.generalPasteboard()
        board.string = text
        let menu = UIMenuController.sharedMenuController()
        menu.setMenuVisible(false, animated: true)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.copy(_:)) {
            return true
        }else{
            return false
        }
    }

}
