//
//  Timer.swift
//  TimerSample
//
//  Created by 雨 on 15/8/14.
//  Copyright © 2015年 Rain. All rights reserved.
//

import Foundation
import UIKit

protocol ReSendSMSDelegate {
    func reSendSMS()
}

class Timer:UIButton {
    
    var verificationCodeBtn: UIButton!
    var countdownTimer: NSTimer?
    
    var delegate: ReSendSMSDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        verificationCodeBtn = UIButton(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        verificationCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        verificationCodeBtn.addTarget(self, action: #selector(verificationCodeBtnClick), forControlEvents: .TouchUpInside)
        self.addSubview(verificationCodeBtn)
        
        verificationCodeBtnClick()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func verificationCodeBtnClick(){
        isCounting = true
        
        //发送验证码
        if delegate != nil {
            delegate?.reSendSMS()
        }
    }
    
    var remainingSeconds: Int = 0 {
        willSet {
            verificationCodeBtn.setTitle("\(newValue)秒后重新获取", forState: .Normal)
            if newValue <= 0 {
                verificationCodeBtn.setTitle("重新获取验证码", forState: .Normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 60
                verificationCodeBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                verificationCodeBtn.backgroundColor = UIColor.getRedColorFirst()
            }
            verificationCodeBtn.enabled = !newValue
        }
    }
    
    func updateTime(timer: NSTimer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
}