//
//  FAQDetailViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit
import SwiftyJSON

class FAQDetailViewController: BaseNavigationController {

    var questionId: String!
    
    //view
    var tableView: UITableView!
    
    //data
    var FAQDetailData = [String]()
    var selectIndexPath: NSIndexPath?
    var isExtension = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTopViewLeftBtnImg("left")
        view.backgroundColor = UIColor.getGrayColorThird()
        
        initData()
    }
    
    //MARK: - 自定义方法
    func initData(){
        DataProvider.sharedInstance.getQuestionDetail(questionId) { (data) in
            print(data)
            if data["status"]["succeed"].intValue == 1{
                let tempArray = data["data"].dictionaryValue["queslist"]!.arrayValue
                for item in tempArray{
                    self.FAQDetailData.append(item["ques_name"].stringValue)
                    self.FAQDetailData.append(item["ques_content"].stringValue)
                }
                
                self.initView()
            }
        }
    }
    
    func initView(){
        tableView = UITableView(frame: CGRectMake(0, top_height, screen_width, screen_height - top_height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = UIColor.getGrayColorThird()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }

}

extension FAQDetailViewController: UITableViewDelegate, UITableViewDataSource{
    //row
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAQDetailData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return UITableViewAutomaticDimension
        }else{
            if selectIndexPath != nil && indexPath.row == selectIndexPath!.row + 1 {
                if isExtension {
                    return UITableViewAutomaticDimension
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FAQDetailTableViewCell.tableViewCellWith(tableView, indexPath: indexPath)
        if indexPath.row % 2 == 0 {
            cell.titleLbl.text = FAQDetailData[indexPath.row]
            if selectIndexPath != nil && indexPath == selectIndexPath {
                if isExtension {
                    cell.stateIv.image = UIImage(named: "pay_success_allow")
                }else{
                    cell.stateIv.image = UIImage(named: "pay_success_allow_down")
                }
            }else{
                cell.stateIv.image = UIImage(named: "pay_success_allow_down")
            }
        }else{
            cell.stateIv.hidden = true
            if selectIndexPath != nil && indexPath.row == selectIndexPath!.row + 1 {
                if isExtension {
                    cell.titleLbl.text = FAQDetailData[indexPath.row]
                }
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
        if indexPath == selectIndexPath {
            isExtension = !isExtension
        }else{
            isExtension = true
        }
        selectIndexPath = indexPath
        tableView.reloadData()
    }

    //section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}