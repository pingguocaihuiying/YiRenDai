//
//  FeedbackViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/7.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class FeedbackViewController: BaseNavigationController, UITextViewDelegate {
    
    var contentTv: UITextView!
    var placeholderLbl: UILabel!
    var inputTxtNumLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.getColorThird()
        setTopViewTitle("意见反馈")
        setTopViewLeftBtnImg("left")
        setTopViewRightBtn("提交")
        
        initView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        contentTv.resignFirstResponder()
    }
    
    override func clickRightBtnEvent() {
        
    }
    
    //MARK: - 自定义方法
    func initView(){
        //contentTv
        contentTv = UITextView(frame: CGRectMake(10, top_height + 20, screen_width - 20, screen_width * 0.6))
        contentTv.delegate = self
        contentTv.layer.masksToBounds = true
        contentTv.layer.cornerRadius = 5
        contentTv.layer.borderWidth = 0.5
        contentTv.font = UIFont.systemFontOfSize(15)
        contentTv.layer.borderColor = UIColor.lightGrayColor().CGColor
        //placeholderLbl
        placeholderLbl = UILabel(frame: CGRectMake(5, 10, 200, 15))
        placeholderLbl.text = "请输入问题或建议"
        placeholderLbl.textColor = UIColor.grayColor()
        placeholderLbl.font = UIFont.systemFontOfSize(15)
        contentTv.addSubview(placeholderLbl)
        //inputTxtNumLbl
        inputTxtNumLbl = UILabel(frame: CGRectMake(contentTv.viewWidth - 130, contentTv.viewHeight - 20, 120, 15))
        inputTxtNumLbl.textColor = UIColor.grayColor()
        inputTxtNumLbl.font = UIFont.systemFontOfSize(15)
        inputTxtNumLbl.textAlignment = .Right
        inputTxtNumLbl.text = "还可以输入200字"
        contentTv.addSubview(inputTxtNumLbl)
        view.addSubview(contentTv)
    }
    
    //MARK: - UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLbl.hidden = false
        }else if textView.text.characters.count <= 200{
            placeholderLbl.hidden = true
            inputTxtNumLbl.text = "还可以输入\(200 - textView.text.characters.count)字"
        }else{
            textView.text = textView.text.substringToIndex(textView.text.startIndex.advancedBy(200))
        }
    }

}
