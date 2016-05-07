//
//  HistoryRecordViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class HistoryRecordViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView(){
        let clMenu = CLMenu(frame: CGRectMake(0, top_height, screen_width, 40), menuArray: ["全部","收入","支出"])
        view.addSubview(clMenu)
    }

}
