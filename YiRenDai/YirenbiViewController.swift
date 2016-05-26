//
//  YirenbiViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/27.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class YirenbiViewController: BaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.getGrayColorThird()
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("历史记录")

        initView()
    }
    
    override func clickRightBtnEvent() {
        let historyRecordVC = HistoryRecordViewController()
        historyRecordVC.navtitle = "历史记录"
        historyRecordVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(historyRecordVC, animated: true)
    }

    //MARK: - 自定义发放
    func initView(){
        //headerView
        let headerView = UIView(frame: CGRectMake(0, top_height, screen_width, 180))
        headerView.backgroundColor = UIColor.getRedColorFirst()
        view.addSubview(headerView)
        //imageView2
        let imageView2 = UIImageView(frame: CGRectMake(14, 20 + 60, screen_width - 28, 60))
        imageView2.image = UIImage(named: "acc_yrd_text")
        imageView2.layer.masksToBounds = true
        imageView2.layer.cornerRadius = 3
        headerView.addSubview(imageView2)
        //imageView
        let imageView = UIImageView(frame: CGRectMake((screen_width - 80) / 2, 30, 80, 70))
        imageView.image = UIImage(named: "acc_yrb_n")
        headerView.addSubview(imageView)
        //detailLbl1
        let detailLbl1 = UILabel(frame: CGRectMake(0, 0, imageView2.viewWidth, imageView2.viewHeight))
        detailLbl1.textColor = UIColor.whiteColor()
        detailLbl1.font = UIFont.systemFontOfSize(14)
        detailLbl1.textAlignment = .Center
        detailLbl1.text = "我的宜人币：0.00个"
        imageView2.addSubview(detailLbl1)
        //ljsyBtn
        let ljsyBtn = UIButton(frame: CGRectMake(14, headerView.viewBottomY + 15, screen_width - 28, 40))
        ljsyBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
        ljsyBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ljsyBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        ljsyBtn.setTitle("立即使用", forState: .Normal)
        view.addSubview(ljsyBtn)
    }

}
