//
//  SettingsViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class SettingsViewController: BaseNavigationController, ChangeGesturePwdDelegate, AlertViewDelegate {
    
    let cellIdentifier = "CellIdentifier"

    //view
    var tableView: UITableView!
    
    //data
    var isSettingGesturePwd = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        
        isSettingGesturePwd = false
        
        initView()
    }
    
    //MARK: - 自定义方法
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.backgroundColor = UIColor.getGrayColorThird()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func clickEvent(sender: UISwitch){
        switch sender.tag {
        case 0:
            if sender.on {
                isSettingGesturePwd = true
                let alertView = AlertView(frame: CGRectMake(20, screen_height / 2 - 200, screen_width - 40, 200))
                alertView.delegate = self
                view.addSubview(alertView)
            }else{
                isSettingGesturePwd = false
                let gesturePasswordVC = GesturePasswordViewController()
                gesturePasswordVC.delegate = self
                gesturePasswordVC.gesturePasswordType = 2
                navigationController?.pushViewController(gesturePasswordVC, animated: true)
            }
            sender.setOn(!isSettingGesturePwd, animated: false)
        default:
            break
        }
    }
    
    // MARK: - AlertViewDelegate
    func clickOK(password: String) {
        if true{
            let gesturePasswordVC = GesturePasswordViewController()
            gesturePasswordVC.delegate = self
            gesturePasswordVC.gesturePasswordType = 1
            navigationController?.pushViewController(gesturePasswordVC, animated: true)
        }
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSettingGesturePwd {
            return 3
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        if isSettingGesturePwd {
            if indexPath.row == 0 {
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "手势密码"
                cell.addSubview(titleLbl)
                //switchBtn
                let switchBtn = UISwitch(frame: CGRectMake(screen_width - 50 - 10, 0, 50, cell.viewHeight))
                switchBtn.center.y = titleLbl.center.y
                switchBtn.setOn(isSettingGesturePwd, animated: false)
                switchBtn.tag = 0
                switchBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
                cell.addSubview(switchBtn)
            }else if indexPath.row == 1{
                cell.accessoryType = .DisclosureIndicator
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "修改手势密码"
                cell.addSubview(titleLbl)
            }else if indexPath.row == 2{
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "修改密码"
                cell.addSubview(titleLbl)
            }
        }else{
            if indexPath.row == 0 {
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "手势密码"
                cell.addSubview(titleLbl)
                //switchBtn
                let switchBtn = UISwitch(frame: CGRectMake(screen_width - 50 - 10, 0, 50, cell.viewHeight))
                switchBtn.tag = 0
                switchBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                switchBtn.center.y = titleLbl.center.y
                switchBtn.setOn(isSettingGesturePwd, animated: false)
                cell.addSubview(switchBtn)
            }else if indexPath.row == 1{
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "修改密码"
                cell.addSubview(titleLbl)
            }
        }
        return cell
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
        if isSettingGesturePwd {
            if indexPath.row == 2{
                let changePwdVC = ChangePwdViewController()
                changePwdVC.accountVale = ToolKit.getStringByKey("userPhone")
                changePwdVC.navtitle = "修改密码"
                self.navigationController?.pushViewController(changePwdVC, animated: true)
            }
        }else{
            if indexPath.row == 1{
                let changePwdVC = ChangePwdViewController()
                changePwdVC.accountVale = ToolKit.getStringByKey("userPhone")
                changePwdVC.navtitle = "修改密码"
                self.navigationController?.pushViewController(changePwdVC, animated: true)
            }
        }
    }
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    //MARK: - ChangeGesturePwdDelegate
    func changeGesturePwd(state: Int) {
        if state == 1 { // 保存手势成功
            isSettingGesturePwd = true
        }else{
            isSettingGesturePwd = false
        }
        tableView.reloadData()
    }
}