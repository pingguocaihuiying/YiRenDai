//
//  OpenBankViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/6/15.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

protocol OpenBankViewControllerDellegate {
    func selectValue(value: String)
}

class OpenBankViewController: BaseNavigationController {
    
    let cellIdentifier = "cellIdentifier"
    
    // view
    var tableView: UITableView!
    var delegate: OpenBankViewControllerDellegate?
    
    // data
    var bankData = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setTopViewTitle("选择开户银行")
        setTopViewLeftBtnImg("left")
        
        initData()
        
    }
    
    // MARK: - 自定义方法
    func initData(){
        var itemBank = JSON(dictionaryLiteral: ("image","icbc"),("name","工商银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","abc"),("name","农业银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","ccb"),("name","建设银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","boc"),("name","中国银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","cmb"),("name","招商银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","cmbc"),("name","民生银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","spdb"),("name","浦发银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","psbc"),("name","邮政储蓄"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","bocm"),("name","交通银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","ceb"),("name","光大银行"))
        bankData.append(itemBank)
        itemBank = JSON(dictionaryLiteral: ("image","gdb"),("name","广发银行"))
        bankData.append(itemBank)
        
        initView()
    }
    
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
    }
}

extension OpenBankViewController: UITableViewDataSource, UITableViewDelegate{
    // UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        for itemView in cell.contentView.subviews{
            itemView.removeFromSuperview()
        }
        // iv
        let iv = UIImageView(frame: CGRectMake(15, (cell.viewHeight - 45) / 2, 45, 45))
        
        print(bankData)
        let dict = bankData[indexPath.row].dictionaryValue
        iv.image = UIImage(named: dict["image"]!.stringValue)
        cell.contentView.addSubview(iv)
        
        // nameLbl
        let nameLbl = UILabel(frame: CGRectMake(iv.viewRightX + 10, 0, 200, cell.viewHeight))
        nameLbl.font = UIFont.systemFontOfSize(16)
        nameLbl.textAlignment = .Left
        nameLbl.text = dict["name"]!.stringValue
        cell.contentView.addSubview(nameLbl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if delegate != nil {
            let dict = bankData[indexPath.row].dictionaryValue
            delegate?.selectValue(dict["name"]!.stringValue)
            self.navigationController?.popViewControllerAnimated(true)
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
