//
//  SettingsViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class SettingsViewController: BaseNavigationController {
    
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
        tableView.backgroundColor = UIColor.getColorThird()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func clickEvent(sender: UISwitch){
        switch sender.tag {
        case 0:
            if sender.on {
                isSettingGesturePwd = true
                let gesturePasswordVC = GesturePasswordViewController()
                gesturePasswordVC.gesturePasswordType = 1
                navigationController?.pushViewController(gesturePasswordVC, animated: true)
            }else{
                isSettingGesturePwd = false
                let gesturePasswordVC = GesturePasswordViewController()
                gesturePasswordVC.gesturePasswordType = 0
                navigationController?.pushViewController(gesturePasswordVC, animated: true)
            }
            tableView.reloadData()
        default:
            break
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
            return 4
        }else{
            return 3
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
                switchBtn.setOn(true, animated: false)
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
                titleLbl.text = "接受推送消息"
                cell.addSubview(titleLbl)
                //switchBtn
                let switchBtn = UISwitch(frame: CGRectMake(screen_width - 50 - 10, 0, 50, cell.viewHeight))
                switchBtn.tag = 1
                switchBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: .ValueChanged)
                switchBtn.center.y = titleLbl.center.y
                cell.addSubview(switchBtn)
            }else if indexPath.row == 3{
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "当前版本"
                cell.addSubview(titleLbl)
                //editionLbl
                let editionLbl = UILabel(frame: CGRectMake(screen_width - 80 - 10, 0, 80, cell.viewHeight))
                editionLbl.textAlignment = .Right
                editionLbl.textColor = UIColor.grayColor()
                editionLbl.font = UIFont.systemFontOfSize(14)
                editionLbl.text = "0.0.1"
                cell.addSubview(editionLbl)
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
                switchBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
                switchBtn.center.y = titleLbl.center.y
                cell.addSubview(switchBtn)
            }else if indexPath.row == 1{
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "接受推送消息"
                cell.addSubview(titleLbl)
                //switchBtn
                let switchBtn = UISwitch(frame: CGRectMake(screen_width - 50 - 10, 0, 50, cell.viewHeight))
                switchBtn.center.y = titleLbl.center.y
                switchBtn.tag = 1
                switchBtn.addTarget(self, action: #selector(clickEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
                cell.addSubview(switchBtn)
            }else if indexPath.row == 2{
                //titleLbl
                let titleLbl = UILabel(frame: CGRectMake(10, 0, 200, cell.viewHeight))
                titleLbl.textAlignment = .Left
                titleLbl.font = UIFont.systemFontOfSize(15)
                titleLbl.text = "当前版本"
                cell.addSubview(titleLbl)
                //editionLbl
                let editionLbl = UILabel(frame: CGRectMake(screen_width - 80 - 10, 0, 80, cell.viewHeight))
                editionLbl.textAlignment = .Right
                editionLbl.textColor = UIColor.grayColor()
                editionLbl.font = UIFont.systemFontOfSize(14)
                editionLbl.text = "0.0.1"
                cell.addSubview(editionLbl)
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
        
    }
    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}