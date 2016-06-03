//
//  LcqDetailViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/11.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class LcqDetailViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("分享")

        initView()
    }

    // MARK: - 自定义方法
    func initView(){
        
    }
    
    override func clickRightBtnEvent() {
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容",
                                                images : UIImage(named: "QQ"),
                                                url : NSURL(string:"http://www.mob.com/#/"),
                                                title : "分享标题",
                                                type : SSDKContentType.WebPage)
        // 2、分享（可以弹出我们的分享菜单和编辑界面）
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames) { (state, platformType, userData, contentEntity, error, end) in
            switch(state){
            case SSDKResponseState.Success:
                self.view.viewAlert(self, title: "提示", msg: "分享成功", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            case SSDKResponseState.Fail:
                self.view.viewAlert(self, title: "提示", msg: "分享失败", cancelButtonTitle: "确定", otherButtonTitle: nil, handler: nil)
            default:
                break
            }
        }
    }

}
