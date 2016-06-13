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
        imageView.image = UIImage(named: "ic_product_soldout")
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
        ljsyBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Disabled)
        ljsyBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        ljsyBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        ljsyBtn.enabled = false
        ljsyBtn.setTitle("立即使用", forState: .Normal)
        view.addSubview(ljsyBtn)
        
        // titleIv
        let titleIv = UIImageView(frame: CGRectMake(14, ljsyBtn.viewBottomY + 25, 14, 14))
        titleIv.image = UIImage(named: "yrb_title")
        view.addSubview(titleIv)
        // titleLbl
        let titleLbl = UILabel(frame: CGRectMake(titleIv.viewRightX + 2, titleIv.viewY, 100, 14))
        titleLbl.textColor = UIColor.grayColor()
        titleLbl.font = UIFont.systemFontOfSize(14)
        titleLbl.text = "使用说明"
        view.addSubview(titleLbl)
        // detailDataArray
        let detailDataArray = ["宜人币可在购买理财产品时充当现金使用", "1个宜人币抵扣1元人民币，购买金额可使用宜人币金额抵扣", "有即将过期宜人币时，会提前30天进行提醒"]
        // redPointView1
        let redPointView1 = UIView(frame: CGRectMake(titleIv.viewX + 2, titleIv.viewBottomY + 2 + 25 / 2, 7, 7))
        redPointView1.backgroundColor = UIColor.redColor()
        redPointView1.layer.masksToBounds = true
        redPointView1.layer.cornerRadius = redPointView1.viewWidth / 2
        view.addSubview(redPointView1)
        // detailTv1
        let detailTv1 = UITextView(frame: CGRectMake(redPointView1.viewRightX + 2, titleIv.viewBottomY + 2, screen_width - titleIv.viewX - 2 - 14, 0))
        detailTv1.text = detailDataArray[0]
        detailTv1.backgroundColor = UIColor.getGrayColorThird()
        detailTv1.textColor = UIColor.grayColor()
        detailTv1.font = UIFont.systemFontOfSize(14)
        detailTv1.scrollEnabled = false
        detailTv1.editable = false
        view.addSubview(detailTv1)
        detailTv1.autoHeight()
        // redPointView2
        let redPointView2 = UIView(frame: CGRectMake(titleIv.viewX + 2, detailTv1.viewBottomY + 25 / 2 - 10, 7, 7))
        redPointView2.backgroundColor = UIColor.redColor()
        redPointView2.layer.masksToBounds = true
        redPointView2.layer.cornerRadius = redPointView2.viewWidth / 2
        view.addSubview(redPointView2)
        // detailTv2
        let detailTv2 = UITextView(frame: CGRectMake(redPointView2.viewRightX + 2, detailTv1.viewBottomY - 10, screen_width - titleIv.viewX - 2 - 14, 0))
        detailTv2.text = detailDataArray[1]
        detailTv2.backgroundColor = UIColor.getGrayColorThird()
        detailTv2.textColor = UIColor.grayColor()
        detailTv2.font = UIFont.systemFontOfSize(14)
        detailTv2.scrollEnabled = false
        detailTv2.editable = false
        view.addSubview(detailTv2)
        detailTv2.autoHeight()
        // redPointView3
        let redPointView3 = UIView(frame: CGRectMake(titleIv.viewX + 2, detailTv2.viewBottomY + 25 / 2 - 10, 7, 7))
        redPointView3.backgroundColor = UIColor.redColor()
        redPointView3.layer.masksToBounds = true
        redPointView3.layer.cornerRadius = redPointView3.viewWidth / 2
        view.addSubview(redPointView3)
        // detailTv3
        let detailTv3 = UITextView(frame: CGRectMake(redPointView3.viewRightX + 2, detailTv2.viewBottomY - 10, screen_width - titleIv.viewX - 2 - 14, 0))
        detailTv3.text = detailDataArray[2]
        detailTv3.backgroundColor = UIColor.getGrayColorThird()
        detailTv3.textColor = UIColor.grayColor()
        detailTv3.font = UIFont.systemFontOfSize(14)
        detailTv3.scrollEnabled = false
        detailTv3.editable = false
        view.addSubview(detailTv3)
        detailTv3.autoHeight()
    }

}
