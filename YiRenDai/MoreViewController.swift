//
//  MoreViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/4/21.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class MoreViewController: BaseNavigationController {
    
    let cellIdentifier = "CellIdentifier"
    let cellIdentifierNib = "ProductListCell"
    
    var tableView: UITableView!
    var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("更多")
        
        initView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateMoreData), name: "updateMoreData", object: nil)
    }
    
    //MARK:自定义方法
    private func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height - tabBar_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.registerNib(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifierNib)
        view.addSubview(tableView)
    }
    
    func clickEvent(sender: UIButton){
        switch sender.tag {
        case 1:
            if logoutBtn.titleLabel?.text == "登录" {
                let loginVC = LoginViewController()
                loginVC.isShowBackBtn = true
                navigationController?.pushViewController(loginVC, animated: true)
            }else{
                view.viewAlert(self, title: "确认退出账号？", msg: nil, cancelButtonTitle: "取消", otherButtonTitle: "确认", handler: { (buttonIndex, action) in
                    if buttonIndex == 1{
                        NSUserDefaults.setUserDefaultValue(false, forKey: "isLogin")
                        self.logoutBtn.setTitle("登录", forState: .Normal)
                        NSNotificationCenter.defaultCenter().postNotificationName("updateMyWealthData", object: nil)
                    }
                })
            }
        default:
            break
        }
    }
    
    func updateMoreData(){
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
    }

}

extension MoreViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let imageView = UIImageView(frame: CGRectMake(0, 0, screen_width, 130))
                imageView.image = UIImage(named: "default_bgimg")
                cell.addSubview(imageView)
            case 1:
                //customBtn1
                let customBtn1 = CLButton(frame: CGRectMake(0, 3, screen_width / 3, 85), imageName: "pinpaijieshao", title: "品牌介绍", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn1)
                //lineView1
                let lineView1 = UIView(frame: CGRectMake(screen_width / 3, 0, 0.25, 90))
                lineView1.backgroundColor = UIColor.getGrayColorFirst()
                cell.addSubview(lineView1)
                //customBtn2
                let customBtn2 = CLButton(frame: CGRectMake(screen_width / 3, 3, screen_width / 3, 85), imageName: "anquanbaozhang", title: "安全保障", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn2)
                //lineView1
                let lineView2 = UIView(frame: CGRectMake(screen_width / 3 * 2 + 0.25, 0, 0.25, 90))
                lineView2.backgroundColor = UIColor.getGrayColorFirst()
                cell.addSubview(lineView2)
                //customBtn3
                let customBtn3 = CLButton(frame: CGRectMake(screen_width / 3 * 2, 3, screen_width / 3, 85), imageName: "zijintuoguan", title: "资金托管", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn3)
            default:
                break
            }
        case 1:
            cell.accessoryType = .DisclosureIndicator
            switch indexPath.row {
            case 0:
                //customBtn1
                let customBtn1 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "guanlituandui", title: "管理团队")
                customBtn1.userInteractionEnabled = false
                cell.addSubview(customBtn1)
            case 1:
                //customBtn2
                let customBtn2 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "lianxiwomen", title: "联系我们")
                customBtn2.userInteractionEnabled = false
                cell.addSubview(customBtn2)
            case 2:
                //customBtn3
                let customBtn3 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "changjianwenti", title: "常见问题")
                customBtn3.userInteractionEnabled = false
                cell.addSubview(customBtn3)
            case 3:
                //customBtn4
                let customBtn4 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "more_team", title: "打赏好评")
                customBtn4.userInteractionEnabled = false
                cell.addSubview(customBtn4)
            default:
                break
            }
        case 2:
            if indexPath.row == 0 {
                cell.accessoryType = .DisclosureIndicator
                //customBtn
                let customBtn = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "shezhi", title: "设置")
                customBtn.userInteractionEnabled = false
                cell.addSubview(customBtn)
                //rightLbl
                let rightLbl = UILabel(frame: CGRectMake(screen_width - 25 - 100, (45 - 21) / 2, 100, 21))
                rightLbl.textAlignment = .Right
                rightLbl.font = UIFont.systemFontOfSize(13)
                rightLbl.textColor = UIColor.grayColor()
                rightLbl.text = "手势密码等"
                cell.addSubview(rightLbl)
            }else{
                for itemView in cell.subviews{
                    itemView.removeFromSuperview()
                }
                cell.backgroundColor = UIColor.getGrayColorThird()
                //退出
                logoutBtn = UIButton(frame: CGRectMake(14, (100 - 60) / 2, screen_width - 14 * 2, 46))
                logoutBtn.setTitle(ToolKit.getBoolByKey("isLogin") ? "安全退出" : "登录", forState: .Normal)
                logoutBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                logoutBtn.setBackgroundImage(UIImage(named: "button_normal"), forState: .Normal)
                logoutBtn.tag = 1
                logoutBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(logoutBtn)
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
                return 130
            default:
                return 90
            }
        case 1:
            return 45
        case 2:
            if indexPath.row == 0 {
                return 45
            }else{
                return 100
            }
        default:
            return 0
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.section {
        case 1:
            if indexPath.row == 0 {
                let manageTeamVC = ManageTeamViewController()
                manageTeamVC.hidesBottomBarWhenPushed = true
                manageTeamVC.navtitle = "管理团队"
                navigationController?.pushViewController(manageTeamVC, animated: true)
            }else if indexPath.row == 1 {
                let contactUsVC = ContactUsViewController()
                contactUsVC.navtitle = "联系我们"
                contactUsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(contactUsVC, animated: true)
            }else if indexPath.row == 2{
                let faqVC = FAQViewController()
                faqVC.hidesBottomBarWhenPushed = true
                faqVC.navtitle = "常见问题"
                navigationController?.pushViewController(faqVC, animated: true)
            }
        case 2:
            let settingVC = SettingsViewController()
            settingVC.navtitle = "设置"
            settingVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(settingVC, animated: true)
        default:
            break
        }
    }
    
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 14
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView(frame: CGRectMake(0, 0, screen_width, 14))
        headView.backgroundColor = UIColor.getGrayColorThird()
        let upLineView = UIView(frame: CGRectMake(0, 0.25, screen_width, 0.25))
        upLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(upLineView)
        let downLineView = UIView(frame: CGRectMake(0, 14 - 0.25, screen_width, 0.25))
        downLineView.backgroundColor = UIColor.getGrayColorSecond()
        headView.addSubview(downLineView)
        return headView
    }
}