//
//  ZijintuoguanViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/8/8.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class ZijintuoguanViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("资金托管")
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    func initView(){
        let contentWv = UIWebView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        contentWv.loadRequest(NSURLRequest(URL: NSURL(string: "\(URL)/web/viewBrand&id=1")!))
        self.view.addSubview(contentWv)
    }

}
