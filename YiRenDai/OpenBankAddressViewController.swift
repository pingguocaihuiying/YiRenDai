//
//  OpenBankAddressViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON
import AFImageHelper
import MJRefresh

protocol OpenBankAddressViewControllerDellegate {
    func selectAddressValue(value: String)
}

class OpenBankAddressViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    var delegate: OpenBankAddressViewControllerDellegate?
    
    // data
    var dataArray = [JSON]()
    var iFlag: String! // 1：省份  2：市
    var selectProvince: String! // 当前选择的省份
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewTitle("选择开户地区")
        setTopViewLeftBtnImg("left")
        
        iFlag = "1"

        initData()
    }

    //MARK: - 自定义方法
    func initData(){
        dataArray.removeAll()
        let stationArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("city", ofType: "plist")!)
        if iFlag == "1" {
            for i in 0 ..< stationArray!.count {
                let proDic = stationArray![i] as! NSDictionary
                let proName = proDic["state"]
                dataArray.append(JSON(proName!))
                
                initView()
            }
        }else if iFlag == "2"{
            for i in 0 ..< stationArray!.count {
                let proDic = stationArray![i] as! NSDictionary
                let proName = proDic["state"] as! String
                let cityListArray = proDic["cities"]
                if proName == selectProvince{
                    dataArray = JSON(cityListArray!).arrayValue
                    break
                }
            }
            tableView.reloadData()
        }
    }
    
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }

}

extension OpenBankAddressViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        for itemView in cell.contentView.subviews{
            itemView.removeFromSuperview()
        }
        
        // nameLbl
        let nameLbl = UILabel(frame: CGRectMake(15, 0, 200, cell.viewHeight))
        nameLbl.font = UIFont.systemFontOfSize(16)
        nameLbl.textAlignment = .Left
        nameLbl.text = dataArray[indexPath.row].stringValue
        cell.contentView.addSubview(nameLbl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if iFlag == "1"{
            iFlag = "2"
            selectProvince = dataArray[indexPath.row].stringValue
            initData()
        }else{
            if delegate != nil {
                var selectAddress: String!
                if selectProvince == dataArray[indexPath.row].stringValue {
                    selectAddress = selectProvince
                }else{
                    selectAddress = "\(selectProvince)\(dataArray[indexPath.row].stringValue)"
                }
                delegate?.selectAddressValue(selectAddress)
                self.navigationController?.popViewControllerAnimated(true)
            }
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
}
