//
//  GesturePasswordViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

class GesturePasswordViewController: UIViewController, VerificationDelegate, ResetDelegate, GesturePasswordDelegate {
    
    var gesturePasswordType: Int!
    
    var gesturePasswordView:GesturePasswordView!
    
    var previousString:String? = ""
    var password:String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gesturePasswordType == 1 {
            reset()
        }else{
            verify()
        }
    }
    
    //MARK: - 重置手势密码
    func reset(){
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.resetDelegate = self
        gesturePasswordView.gesturePasswordDelegate = self
        gesturePasswordView.tentacleView!.style = 2
        gesturePasswordView.forgetButton!.hidden = true
        gesturePasswordView.changeButton!.hidden = true
        gesturePasswordView.setTopViewTitle("开启手势密码")
        gesturePasswordView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gesturePasswordView)
        
        gesturePasswordView.state!.text = "绘制解锁图案"
        
    }
    
    //MARK: - 验证手势密码
    func verify(){
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.rerificationDelegate = self
        gesturePasswordView.tentacleView!.style = 1
        gesturePasswordView.gesturePasswordDelegate = self
        gesturePasswordView.setTopViewTitle("手势密码")
        gesturePasswordView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(gesturePasswordView)
        
        gesturePasswordView.state!.text = "输入原手势密码"
    }
    
    //验证密码
    func verification(result:String)->Bool{
        
        // println("password:\(result)====\(password)")
        if(result == password){
            
            gesturePasswordView.state!.textColor = UIColor.whiteColor()
            gesturePasswordView.state!.text = "输入正确"
            
            return true
        }
        gesturePasswordView.state!.textColor = UIColor.redColor()
        gesturePasswordView.state!.text = "手势密码错误"
        return false
    }
    
    //重设密码
    func resetPassword(result: String) -> Bool {
        if(previousString == ""){
            previousString = result
            gesturePasswordView.tentacleView!.enterArgin()
            gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            gesturePasswordView.state!.text = "再次绘制解锁图案"
            
            return true
        }else{
            
            if(result == previousString){
                
                
                
                //KeychainWrapper.setString(result, forKey: secKey)
                
                gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
                gesturePasswordView.state!.text = "已保存手势密码"
                
                
                return true;
            }else{
                previousString = "";
                gesturePasswordView.state!.textColor = UIColor.redColor()
                gesturePasswordView.state!.text = "两次密码不一致，请重新输入"
                
                return false
            }
            
        }
    }
    
    //MARK: - 改变手势密码
    func change(){
        
        print("改变手势密码")
        
    }
    
    //MARK: - 忘记密码
    func forget(){
        print("忘记密码")
    }

    //MARK: - 点击左按钮返回
    func clickLeftBtnEventGesturePwd() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
