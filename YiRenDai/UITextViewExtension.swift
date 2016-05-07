//
//  UITextViewExtentsion.swift
//  ProjectFrame
//
//  Created by Rain on 16/3/21.
//  Copyright © 2016年 rain. All rights reserved.
//

import Foundation

extension UITextView{
    /**
     * 自适应高度
     * 注:必须要在addSubview之后调用，否则不起作用
     */
    func autoHeight(){
        let contentSize = self.sizeThatFits(self.bounds.size)
        self.frame.size.height = contentSize.height
    }
}