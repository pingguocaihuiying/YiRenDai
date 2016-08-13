//
//  ActivityDetailViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/8/14.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ActivityDetailViewController: BaseNavigationController {
    
    var activityId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("活动详情")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    func initView(){
        let contentWv = UIWebView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        contentWv.loadRequest(NSURLRequest(URL: NSURL(string: "\(URL)/web/ViewActivity&id=\(activityId)")!))
        self.view.addSubview(contentWv)
    }

}
