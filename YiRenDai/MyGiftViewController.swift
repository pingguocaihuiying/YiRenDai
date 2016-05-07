//
//  MyGiftViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class MyGiftViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    //MARK: - 自定义方法
    func initView(){
        //imageView
        let imageView = UIImageView(frame: CGRectMake((screen_width - 80) / 2, screen_width * 0.4, 80, 70))
        imageView.image = UIImage(named: "acc_yrb_n")
        view.addSubview(imageView)
        //detailLbl1
        let detailLbl1 = UILabel(frame: CGRectMake(0, imageView.viewBottomY + 40, screen_width, 14))
        detailLbl1.textColor = UIColor.grayColor()
        detailLbl1.font = UIFont.systemFontOfSize(14)
        detailLbl1.textAlignment = .Center
        detailLbl1.text = "您目前的会员等级还不具备领取资格哦"
        view.addSubview(detailLbl1)
        //detailLbl2
        let detailLbl2 = UILabel(frame: CGRectMake(0, detailLbl1.viewBottomY + 10, screen_width, 14))
        detailLbl2.font = UIFont.systemFontOfSize(14)
        detailLbl2.textAlignment = .Center
        detailLbl2.text = "g购买理财即升级，升级即可领礼品"
        view.addSubview(detailLbl2)
        //detailLbl3
        let detailLbl3 = UILabel(frame: CGRectMake(0, detailLbl2.viewBottomY + 10, screen_width, 14))
        detailLbl3.font = UIFont.systemFontOfSize(14)
        detailLbl3.textAlignment = .Center
        detailLbl3.text = "快去升级吧~"
        view.addSubview(detailLbl3)
        
        
    }

}
