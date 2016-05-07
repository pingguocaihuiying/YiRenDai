//
//  TixianViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/26.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class TixianViewController: BaseNavigationController {

    var tableView: UITableView!
    var logoutBtn: UIButton!
    var amountTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        amountTxt.resignFirstResponder()
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.backgroundColor = UIColor.getColorThird()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .None
        //headerView
        let headerView = UIView(frame: CGRectMake(0, 0, screen_width, 90))
        tableView.tableHeaderView = headerView
        //bgIv
        let bgIv = UIImageView(frame: headerView.frame)
        bgIv.image = UIImage(named: "acc_vip_head_bg")
        headerView.addSubview(bgIv)
        //detailLbl1
        let detailLbl1 = UILabel(frame: CGRectMake(20, 20, 150, 15))
        detailLbl1.font = UIFont.systemFontOfSize(15)
        detailLbl1.textColor = UIColor.whiteColor()
        detailLbl1.text = "可提现金额"
        headerView.addSubview(detailLbl1)
        //detailLbl2
        let detailLbl2 = UILabel(frame: CGRectMake(20, detailLbl1.viewBottomY + 15, 44, 21))
        detailLbl2.textColor = UIColor.whiteColor()
        detailLbl2.font = UIFont.systemFontOfSize(20)
        detailLbl2.text = "0.00"
        headerView.addSubview(detailLbl2)
        //detailLbl3
        let detailLbl3 = UILabel(frame: CGRectMake(detailLbl2.viewRightX, detailLbl2.viewY + 1, 20, 21))
        detailLbl3.textColor = UIColor.whiteColor()
        detailLbl3.font = UIFont.systemFontOfSize(14)
        detailLbl3.text = "元"
        headerView.addSubview(detailLbl3)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        //footerView
        let footerView = UIView(frame: CGRectMake(0, screen_height - 60, screen_width, 60))
        view.addSubview(footerView)
        //detailLbl4
        let detailLbl4 = UILabel(frame: CGRectMake(0, 0, screen_width, 12))
        detailLbl4.textColor = UIColor.lightGrayColor()
        detailLbl4.textAlignment = .Center
        detailLbl4.font = UIFont.systemFontOfSize(12)
        detailLbl4.text = "提现免手续费"
        footerView.addSubview(detailLbl4)
        //detailLbl5
        let detailLbl5 = UILabel(frame: CGRectMake(0, detailLbl4.viewBottomY + 5, screen_width, 12))
        detailLbl5.textColor = UIColor.lightGrayColor()
        detailLbl5.textAlignment = .Center
        detailLbl5.font = UIFont.systemFontOfSize(12)
        detailLbl5.text = "一般24小时到账，最迟不超过3个工作日"
        footerView.addSubview(detailLbl5)
    }

}

extension TixianViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRectMake(0, 0, screen_width, 0))
        cell.selectionStyle = .None
        if indexPath.section == 0{
            //detail1
            let detail1 = UILabel(frame: CGRectMake(20, 0, 70, 50))
            detail1.textAlignment = .Left
            detail1.font = UIFont.systemFontOfSize(15)
            detail1.text = "提现金额"
            cell.addSubview(detail1)
            //amountTxt
            amountTxt = UITextField(frame: CGRectMake(detail1.viewRightX + 5, 0, screen_width - 20 - 60 - 20 - 20, 50))
            amountTxt.font = UIFont.systemFontOfSize(15)
            amountTxt.placeholder = "提现金额最少50元"
            cell.addSubview(amountTxt)
            //detail2
            let detail2 = UILabel(frame: CGRectMake(screen_width - 20 - 20, 0, 20, 50))
            detail2.textAlignment = .Right
            detail2.font = UIFont.systemFontOfSize(15)
            detail2.text = "元"
            cell.addSubview(detail2)
        }else if indexPath.section == 1{
            cell.accessoryType = .DisclosureIndicator
            //detail1
            let detail1 = UILabel(frame: CGRectMake(20, 0, 150, 50))
            detail1.textAlignment = .Left
            detail1.font = UIFont.systemFontOfSize(15)
            detail1.text = "添加提现银行卡"
            cell.addSubview(detail1)
        }else{
            cell.backgroundColor = UIColor.getColorThird()
            let ljtxBtn = UIButton(frame: CGRectMake(20, 30, screen_width - 40, 45))
            ljtxBtn.setBackgroundImage(UIImage(named: "button_no"), forState: .Normal)
            ljtxBtn.setTitle("立即提现", forState: .Normal)
            ljtxBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            cell.addSubview(ljtxBtn)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 100
        }else{
            return 50
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector(Selector("setSeparatorInset:")){
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        if cell .respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")){
            cell.preservesSuperviewLayoutMargins = false
        }
    }
    
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }else{
            return 14
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, screen_width, 14))
        headView.backgroundColor = UIColor.getColorThird()
        let upLineView = UIView(frame: CGRectMake(0, 0.25, screen_width, 0.25))
        upLineView.backgroundColor = UIColor.getColorSecond()
        headView.addSubview(upLineView)
        let downLineView = UIView(frame: CGRectMake(0, 14 - 0.25, screen_width, 0.25))
        downLineView.backgroundColor = UIColor.getColorSecond()
        headView.addSubview(downLineView)
        return headView
    }
}
