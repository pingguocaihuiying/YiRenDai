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
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 2)], withRowAnimation: .Automatic)
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
    
    func clickEvent(sender: AnyObject){
        switch sender.tag {
        case 1:
            if logoutBtn.titleLabel?.text == "登录" {
                let loginVC = LoginViewController()
                navigationController?.pushViewController(loginVC, animated: true)
            }else{
                view.viewAlert(self, title: "确认退出账号？", msg: nil, cancelButtonTitle: "取消", otherButtonTitle: "确认", handler: { (buttonIndex, action) in
                    if buttonIndex == 1{
                        NSUserDefaults.setUserDefaultValue(false, forKey: "isLogin")
                        self.logoutBtn.setTitle("登录", forState: .Normal)
                        NSNotificationCenter.defaultCenter().postNotificationName("updateData", object: nil)
                    }
                })
            }
        default:
            break
        }
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
            return 4
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let imageView = UIImageView(frame: CGRectMake(0, 0, screen_width, 130))
                imageView.image = UIImage(named: "more_video")
                cell.addSubview(imageView)
            case 1:
                //customBtn1
                let customBtn1 = CLButton(frame: CGRectMake(0, 0, screen_width / 3, 90), imageName: "zhanweitu", title: "品牌介绍", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn1)
                //lineView1
                let lineView1 = UIView(frame: CGRectMake(screen_width / 3, 0, 0.25, 90))
                lineView1.backgroundColor = UIColor.getColorSecond()
                cell.addSubview(lineView1)
                //customBtn2
                let customBtn2 = CLButton(frame: CGRectMake(screen_width / 3, 0, screen_width / 3, 90), imageName: "zhanweitu", title: "安全保障", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn2)
                //lineView1
                let lineView2 = UIView(frame: CGRectMake(screen_width / 3 * 2 + 0.25, 0, 0.25, 90))
                lineView2.backgroundColor = UIColor.getColorSecond()
                cell.addSubview(lineView2)
                //customBtn3
                let customBtn3 = CLButton(frame: CGRectMake(screen_width / 3 * 2, 0, screen_width / 3, 90), imageName: "zhanweitu", title: "资金托管", detail: "中国知名P2P平台纽交所上市公司")
                cell.addSubview(customBtn3)
            default:
                break
            }
        case 1:
            cell.accessoryType = .DisclosureIndicator
            switch indexPath.row {
            case 0:
                //customBtn1
                let customBtn1 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "more_team", title: "管理团队")
                customBtn1.userInteractionEnabled = false
                cell.addSubview(customBtn1)
            case 1:
                //customBtn2
                let customBtn2 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "more_team", title: "联系我们")
                customBtn2.userInteractionEnabled = false
                cell.addSubview(customBtn2)
            case 2:
                //customBtn3
                let customBtn3 = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "more_team", title: "常见问题")
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
                let customBtn = CLButton(frame: CGRectMake(14, 0, screen_width, 45), imageName: "more_team", title: "设置")
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
                cell.backgroundColor = UIColor.getColorThird()
                //退出
                logoutBtn = UIButton(frame: CGRectMake(14, (100 - 60) / 2, screen_width - 14 * 2, 46))
                logoutBtn.setTitle(ToolKit.isLogin() ? "安全退出" : "登录", forState: .Normal)
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
        switch indexPath.section {
        case 1:
            if indexPath.row == 1 {
                let contactUsVC = ContactUsViewController()
                contactUsVC.navtitle = "联系我们"
                contactUsVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(contactUsVC, animated: true)
            }
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