//
//  MyWealthViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/20.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class MyWealthViewController: BaseViewController {

    let cellIdentifier = "CellIdentifier"
    
    //view
    var tableView: UITableView!
    var loginVC: LoginViewController!
    
    // data
    var buyProductData: JSON?
    var buyProductIsEmpty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isLogin = NSUserDefaults.getUserDefaultValue("isLogin") == nil ? false : (NSUserDefaults.getUserDefaultValue("isLogin")?.boolValue)!
        if isLogin {
            initView()
        }else{
            loginVC = LoginViewController()
            self.view.addSubview(loginVC.view)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateMyWealthData(_:)), name: "updateMyWealthData", object: nil)
    }
    
    //MARK:自定义方法
    private func initView(){
        let isLogin = NSUserDefaults.getUserDefaultValue("isLogin") == nil ? false : (NSUserDefaults.getUserDefaultValue("isLogin")?.boolValue)!
        if isLogin {
            tableView = UITableView(frame: CGRectMake(0, 0, screen_width, screen_height - tabBar_height))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
            view.addSubview(tableView)
            
            //下拉刷新
            tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.refreshData))
            tableView.mj_header.beginRefreshing()
        }else{
            loginVC = LoginViewController()
            loginVC.title = "我的财富"
            loginVC.targetNav = self.navigationController
            self.view.addSubview(loginVC.view)
        }
    }
    
    func refreshData(){
        //刷新结束
        tableView.mj_header.endRefreshing()
        //刷新数据
        tableView.reloadData()
    }
    
    func clickEvent(sender: UIButton){
        switch sender.tag {
        case 1:
            let myAccountVC = MyAccountViewController()
            myAccountVC.navtitle = "我的账户"
            myAccountVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(myAccountVC, animated: true)
        case 2:
            let myGiftVC = MyGiftViewController()
            myGiftVC.navtitle = "我的礼品"
            myGiftVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(myGiftVC, animated: true)
        case 3:
            let vipVC = VIPViewController()
            vipVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vipVC, animated: true)
        case 4:
            let yirenbiVC = YirenbiViewController()
            yirenbiVC.navtitle = "宜人币"
            yirenbiVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(yirenbiVC, animated: true)
        case 5:
            let youhuiquanVC = YouhuiquanViewController()
            youhuiquanVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(youhuiquanVC, animated: true)
        case 6:
            NSNotificationCenter.defaultCenter().postNotificationName("setDefaultSelectTabBarItem", object: nil, userInfo: ["index" : 1])
        default:
            break
        }
    }
    
    func updateMyWealthData(notification: NSNotification){
        initView()
    }
    
}

extension MyWealthViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            if true {
                buyProductIsEmpty = false
                return 1 + 5
            }else{
                buyProductIsEmpty = true
                return 1
            }
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        for itemView in cell.contentView.subviews{
            itemView.removeFromSuperview()
        }
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                //背景
                let bgImageView = UIImageView(frame: CGRectMake(0, 0, screen_width, 160))
                bgImageView.contentMode = .ScaleAspectFill
                bgImageView.clipsToBounds = true;
                bgImageView.image = UIImage(named: "acc_vip_head_bg")
                cell.contentView.addSubview(bgImageView)
            
                //背景上的内容
                let contentView = UIView(frame: bgImageView.frame)
                contentView.backgroundColor = UIColor.clearColor()
                cell.contentView.addSubview(contentView)
                // 头像前面的三个小圆点图标
                let imageView1 = UIImageView(frame: CGRectMake(14, 55, 5, 20))
                imageView1.image = UIImage(named: "more")
                contentView.addSubview(imageView1)
                // 头像
                let imageView2 = UIImageView(frame: CGRectMake(imageView1.viewRightX + 5, 43, 45, 45))
                imageView2.contentMode = .ScaleAspectFit
                imageView2.image = UIImage(named: "touxiang")
                contentView.addSubview(imageView2)
                //name
                let nameLbl = UILabel(frame: CGRectMake(imageView2.viewRightX + 5, imageView2.viewY + 2, 100, 21))
                nameLbl.text = "姓名"
                nameLbl.font = UIFont.systemFontOfSize(17)
                nameLbl.textColor = UIColor.whiteColor()
                contentView.addSubview(nameLbl)
                //会员等级
                let vipLevelLbl = UILabel(frame: CGRectMake(nameLbl.viewX, nameLbl.viewBottomY + 2, 100, 21))
                vipLevelLbl.text = "会员等级V0"
                vipLevelLbl.textColor = UIColor.whiteColor()
                vipLevelLbl.font = UIFont.systemFontOfSize(13)
                contentView.addSubview(vipLevelLbl)
                //我的账户点击button
                let myAccountBtn = UIButton(frame: CGRectMake(14, 40, 150, 50))
                myAccountBtn.tag = 1
                myAccountBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(myAccountBtn)
                //理财中金额
                let lcAmountTitleLbl = UILabel(frame: CGRectMake(imageView1.viewX, imageView2.viewBottomY + 10, 100, 21))
                lcAmountTitleLbl.font = UIFont.systemFontOfSize(15)
                lcAmountTitleLbl.textColor = UIColor.whiteColor()
                lcAmountTitleLbl.text = "理财中金额"
                contentView.addSubview(lcAmountTitleLbl)
                let LcAmountLbl = UILabel(frame: CGRectMake(lcAmountTitleLbl.viewX, lcAmountTitleLbl.viewBottomY + 5, 100, 21))
                LcAmountLbl.font = UIFont.systemFontOfSize(25)
                LcAmountLbl.textColor = UIColor.whiteColor()
                LcAmountLbl.text = "0"
                contentView.addSubview(LcAmountLbl)
                //在中间添加一条竖线
                let lineView = UIView(frame: CGRectMake(screen_width / 2, imageView2.viewBottomY + 5, 0.5, lcAmountTitleLbl.viewHeight + 5 + LcAmountLbl.viewHeight + 10))
                lineView.backgroundColor = UIColor.whiteColor()
                contentView.addSubview(lineView)
                //预期总收益
                let yqAmountTitleLbl = UILabel(frame: CGRectMake(screen_width - 14 - 75, imageView2.viewBottomY + 10, 75, 21))
                yqAmountTitleLbl.font = UIFont.systemFontOfSize(15)
                yqAmountTitleLbl.textColor = UIColor.whiteColor()
                yqAmountTitleLbl.text = "预期总收益"
                contentView.addSubview(yqAmountTitleLbl)
                let yqAmountLbl = UILabel(frame: CGRectMake(yqAmountTitleLbl.viewX, yqAmountTitleLbl.viewBottomY + 5, 75, 21))
                yqAmountLbl.font = UIFont.systemFontOfSize(25)
                yqAmountLbl.textColor = UIColor.whiteColor()
                yqAmountLbl.textAlignment = .Right
                yqAmountLbl.text = "0.00"
                contentView.addSubview(yqAmountLbl)
            case 1:
                let bgIv = UIImageView(frame: CGRectMake(0, 0, screen_width, 35))
                bgIv.image = UIImage(named: "acc_head_push")
                cell.contentView.addSubview(bgIv)
                //可用金额
                let kyAmountLbl = UILabel(frame: CGRectMake(14, 0, 200, 35))
                kyAmountLbl.textColor = UIColor.whiteColor()
                kyAmountLbl.font = UIFont.systemFontOfSize(15)
                kyAmountLbl.text = "可用金额：0.00"
                cell.contentView.addSubview(kyAmountLbl)
                
                //提现按钮和图标
                let rightIv = UIImageView(frame: CGRectMake(screen_width - 14 - 10, (35 - 15) / 2, 15, 15))
                rightIv.image = UIImage(named: "whitenext")
                cell.addSubview(rightIv)
                let txLbl = UILabel(frame: CGRectMake(rightIv.viewX - 30 - 2, 0, 30, 35))
                txLbl.textColor = UIColor.whiteColor()
                txLbl.font = UIFont.systemFontOfSize(15)
                txLbl.text = "提现"
                cell.contentView.addSubview(txLbl)
            case 2:
                //imageBtn1
                let imageBtn1 = CLButton(frame: CGRectMake(0, 15, screen_width / 4, 60))
                imageBtn1.setImage(UIImage(named: "Gift"), forState: .Normal)
                imageBtn1.setTitle("礼品", forState: .Normal)
                imageBtn1.setTitleColor(UIColor.grayColor(), forState: .Normal)
                imageBtn1.tag = 2
                imageBtn1.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(imageBtn1)
                
                //imageBtn2
                let imageBtn2 = CLButton(frame: CGRectMake(screen_width / 4, 15, screen_width / 4, 60))
                imageBtn2.setImage(UIImage(named: "User"), forState: .Normal)
                imageBtn2.setTitle("会员", forState: .Normal)
                imageBtn2.setTitleColor(UIColor.grayColor(), forState: .Normal)
                imageBtn2.tag = 3
                imageBtn2.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(imageBtn2)
                
                //imageBtn3
                let imageBtn3 = CLButton(frame: CGRectMake(screen_width / 4 * 2, 15, screen_width / 4, 60))
                imageBtn3.setImage(UIImage(named: "jinbi"), forState: .Normal)
                imageBtn3.setTitle("宜人币", forState: .Normal)
                imageBtn3.tag = 4
                imageBtn3.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                imageBtn3.setTitleColor(UIColor.grayColor(), forState: .Normal)
                cell.contentView.addSubview(imageBtn3)
                
                //imageBtn4
                let imageBtn4 = CLButton(frame: CGRectMake(screen_width / 4 * 3, 15, screen_width / 4, 60))
                imageBtn4.setImage(UIImage(named: "youhuiquan"), forState: .Normal)
                imageBtn4.setTitle("优惠券", forState: .Normal)
                imageBtn4.tag = 5
                imageBtn4.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                imageBtn4.setTitleColor(UIColor.grayColor(), forState: .Normal)
                cell.contentView.addSubview(imageBtn4)
            default:
                break
            }
            case 1:
                if buyProductIsEmpty {
                    //imageView1
                    let imageView1 = UIImageView(frame: CGRectMake((screen_width - 70) / 2, 20, 70, 70))
                    imageView1.image = UIImage(named: "weigoumai")
                    cell.contentView.addSubview(imageView1)
                    //textLbl1
                    let textLbl1 = UILabel(frame: CGRectMake(0, imageView1.viewBottomY + 10, screen_width, 21))
                    textLbl1.text = "您尚未购买宜定盈"
                    textLbl1.textColor = UIColor.lightGrayColor()
                    textLbl1.font = UIFont.systemFontOfSize(14)
                    textLbl1.textAlignment = .Center
                    cell.contentView.addSubview(textLbl1)
                    //textLbl2
                    let textLbl2 = UILabel(frame: CGRectMake(0, textLbl1.viewBottomY, screen_width, 21))
                    textLbl2.text = "宜定盈年化收益率10.2%，快去购买吧！"
                    textLbl2.textColor = UIColor.lightGrayColor()
                    textLbl2.font = UIFont.systemFontOfSize(14)
                    textLbl2.textAlignment = .Center
                    cell.contentView.addSubview(textLbl2)
                    //goLcBtn
                    let goLcBtn = UIButton(frame: CGRectMake(14, textLbl2.viewBottomY + 10, screen_width - 14 * 2, 46))
                    goLcBtn.setTitle("去理财", forState: .Normal)
                    goLcBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    goLcBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
                    goLcBtn.tag = 6
                    goLcBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                    cell.contentView.addSubview(goLcBtn)
                }else{
                    if indexPath.row == 0 {
                        let titleLbl = UILabel(frame: CGRectMake(20, 0, screen_width - 10, cell.viewHeight))
                        titleLbl.textAlignment = .Left
                        titleLbl.text = "我的宜定盈"
                        cell.contentView.addSubview(titleLbl)
                    }else{
                        // leftView
                        let leftView = UIView(frame: CGRectMake(20, 10, cell.viewHeight - 20, cell.viewHeight - 20))
                        leftView.layer.masksToBounds = true
                        leftView.layer.borderWidth = 1
                        leftView.layer.borderColor = UIColor.getRedColorSecond().CGColor
                        leftView.layer.cornerRadius = 8
                        cell.contentView.addSubview(leftView)
                        // detaiLbl1
                        let detaiLbl1 = UILabel(frame: CGRectMake(0, 10, leftView.viewWidth, 16))
                        detaiLbl1.textAlignment = .Center
                        detaiLbl1.textColor = UIColor.getRedColorSecond()
                        detaiLbl1.font = UIFont.systemFontOfSize(16)
                        detaiLbl1.text = "退出中"
                        leftView.addSubview(detaiLbl1)
                        // detaiLbl2
                        let detaiLbl2 = UILabel(frame: CGRectMake(0, (leftView.viewHeight - 16) / 2, leftView.viewWidth, 16))
                        detaiLbl2.textAlignment = .Center
                        detaiLbl2.textColor = UIColor.grayColor()
                        detaiLbl2.font = UIFont.systemFontOfSize(14)
                        detaiLbl2.text = "距离还"
                        leftView.addSubview(detaiLbl2)
                        // detaiLbl3
                        let detaiLbl3 = UILabel(frame: CGRectMake(0, detaiLbl2.viewBottomY + 5, leftView.viewWidth, 16))
                        detaiLbl3.textAlignment = .Center
                        detaiLbl3.textColor = UIColor.getRedColorSecond()
                        detaiLbl3.font = UIFont.systemFontOfSize(12)
                        let str = NSMutableAttributedString(string: "0天")
                        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.getRedColorSecond(), range: NSMakeRange(0, 1))
                        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(1, 1))
                        detaiLbl3.attributedText = str
                        leftView.addSubview(detaiLbl3)
                        // titleLbl
                        let titleLbl = UILabel(frame: CGRectMake(leftView.viewRightX + 10, leftView.viewY + 2, 150, 21))
                        titleLbl.text = "12月期宜定盈"
                        titleLbl.textColor = UIColor.grayColor()
                        cell.contentView.addSubview(titleLbl)
                        // moneyLbl
                        let moneyLbl = UILabel(frame: CGRectMake(titleLbl.viewX, (cell.viewHeight - 21) / 2, 150, 21))
                        moneyLbl.text = "金额：500000"
                        moneyLbl.textColor = UIColor.grayColor()
                        moneyLbl.font = UIFont.systemFontOfSize(15)
                        cell.contentView.addSubview(moneyLbl)
                        // shouyiLbl
                        let shouyiLbl = UILabel(frame: CGRectMake(titleLbl.viewX, moneyLbl.viewBottomY + 5, 150, 21))
                        shouyiLbl.text = "金额：500"
                        shouyiLbl.textColor = UIColor.grayColor()
                        shouyiLbl.font = UIFont.systemFontOfSize(15)
                        cell.contentView.addSubview(shouyiLbl)
                        // stateLbl
                        let stateLbl = UILabel(frame: CGRectMake(screen_width - 10 - 70, titleLbl.viewY, 65, 25))
                        stateLbl.text = "退出中"
                        stateLbl.font = UIFont.systemFontOfSize(14)
                        stateLbl.textColor = UIColor.getRedColorSecond()
                        stateLbl.textAlignment = .Center
                        stateLbl.layer.masksToBounds = true
                        stateLbl.layer.borderWidth = 1
                        stateLbl.layer.borderColor = UIColor.getRedColorSecond().CGColor
                        stateLbl.layer.cornerRadius = 10
                        cell.contentView.addSubview(stateLbl)
                    }
                }
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 160
            case 1:
                return 35
            case 2:
                return 80
            default:
                return 0
            }
        case 1:
            if buyProductIsEmpty {
                return 200
            }else{
                if indexPath.row == 0 {
                    return 44
                }else{
                    return 100
                }
            }
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if cell.respondsToSelector(Selector("setLayoutMargins:")) {
                cell.layoutMargins = UIEdgeInsets(top: 0, left: screen_width, bottom: 0, right: 0)
            }
            
            if cell.respondsToSelector(Selector("setSeparatorInset:")){
                cell.separatorInset = UIEdgeInsets(top: 0, left: screen_width, bottom: 0, right: 0)
            }
            
            if cell .respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")){
                cell.preservesSuperviewLayoutMargins = false
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                let tixianVC = TixianViewController()
                tixianVC.navtitle = "提现"
                tixianVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(tixianVC, animated: true)
            }
        }
    }
    
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 10
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, screen_width, 10))
        headView.backgroundColor = UIColor.getGrayColorThird()
        let upLineView = UIView(frame: CGRectMake(0, 0.25, screen_width, 0.25))
        upLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(upLineView)
        let downLineView = UIView(frame: CGRectMake(0, 10 - 0.25, screen_width, 0.25))
        downLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(downLineView)
        return headView
    }
}