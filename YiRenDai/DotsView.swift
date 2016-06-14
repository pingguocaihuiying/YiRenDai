//
//  DotsView.swift
//  YiRenDai
//
//  Created by Rain on 16/6/14.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class DotsView: UIView {
    
    var dotsColor: UIColor!
    
    init(frame: CGRect, dotsColor: UIColor = UIColor.grayColor()) {
        super.init(frame: frame)
        self.dotsColor = dotsColor
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView(){
        let dotsView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        dotsView.backgroundColor = dotsColor
        dotsView.layer.masksToBounds = true
        dotsView.layer.cornerRadius = self.frame.size.width / 2
        self.addSubview(dotsView)
    }
}
