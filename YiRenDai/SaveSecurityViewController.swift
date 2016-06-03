//
//  SaveSecurityViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import CLCycleScrollView
import SwiftyJSON

class SaveSecurityViewController: BaseNavigationController {
    
    var cycleScrollView: CycleScrollView!
    var saveSecurityData: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("安全保障")
        setTopViewLeftBtnImg("left")
        
        initData()
    }
    
    // MARK: - 自定义方法
    func initData(){
        DataProvider.sharedInstance.getSlide("2") { (data) in
            if data["status"]["succeed"].intValue == 1{
                self.saveSecurityData = data["data"]["slidelist"]
                self.initView()
            }else{
                LoadingAnimation.showError(self, msg: nil)
            }
        }
    }

    func initView(){
        var imageArray = [String]()
        if saveSecurityData != nil && saveSecurityData?.count > 0 {
            for i in 0 ..< saveSecurityData!.count{
                imageArray.append(saveSecurityData![i]["slide_img"].stringValue)
            }
        }
        cycleScrollView = CycleScrollView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height), imageArray: imageArray, placeholder: UIImage(named: "default_bgimg"))
        cycleScrollView.currentPageControlColor = UIColor.redColor()
        cycleScrollView.pageControlTintColor = UIColor.whiteColor()
        cycleScrollView.setUpCircleView()
        view.addSubview(cycleScrollView)
    }

}
