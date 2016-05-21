//
//  GesturePasswordViewController.swift
//  YiRenDai
//
//  Created by Rain on 16/5/12.
//  Copyright © 2016年 YiRenDai. All rights reserved.
//

import UIKit

protocol ChangeGesturePwdDelegate {
    func changeGesturePwd(state: Int)
}

class GesturePasswordViewController: UIViewController, VerificationDelegate, ResetDelegate, GesturePasswordDelegate {
    
    var gesturePasswordType: Int!
    
    var gesturePasswordView:GesturePasswordView!
    
    var previousString:String? = ""
    var password:String? = ""
    
    var delegate: ChangeGesturePwdDelegate?
    
    //var secKey:String = "GesturePassword4Swift"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if gesturePasswordType == 1{
            self.reset()
        }
        else if gesturePasswordType == 2{
            self.verify()
        }
        
    }
    
    //MARK: - 重置手势密码
    func reset(){
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.resetDelegate = self
        gesturePasswordView.gesturePasswordDelegate = self
        gesturePasswordView.tentacleView!.style = 2
        gesturePasswordView.forgetButton!.hidden = true
        gesturePasswordView.backgroundColor = UIColor.whiteColor()
        gesturePasswordView.setTopViewTitle("开启手势密码")
        self.view.addSubview(gesturePasswordView)
        
        gesturePasswordView.state!.text = "绘制解锁图案"
        
    }
    
    //MARK: - 验证手势密码
    func verify(){
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.rerificationDelegate = self
        gesturePasswordView.gesturePasswordDelegate = self
        gesturePasswordView.tentacleView!.style = 1
        gesturePasswordView.changeButton!.hidden = true
        gesturePasswordView.backgroundColor = UIColor.whiteColor()
        gesturePasswordView.setTopViewTitle("手势密码")
        self.view.addSubview(gesturePasswordView)
        gesturePasswordView.state!.text = "输入原手势密码"
        
    }
    
    func verification(result:String)->Bool{
        if(result == password){
            gesturePasswordView.state!.textColor = UIColor.whiteColor()
            gesturePasswordView.state!.text = "输入正确"
            if delegate != nil {
                delegate?.changeGesturePwd(0)
            }
            backFunc()
            return true
        }
        gesturePasswordView.tentacleView!.enterArgin()
        gesturePasswordView.state!.textColor = UIColor.redColor()
        gesturePasswordView.state!.text = "手势密码错误，请重新绘制"
        return false
    }
    
    func resetPassword(result: String) -> Bool {
        if result.characters.count < 4{
            gesturePasswordView.state!.text = "至少连接4个点，请重新绘制"
            return false
        }
        if(previousString == ""){
            previousString = result
            gesturePasswordView.tentacleView!.enterArgin()
            gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            gesturePasswordView.state!.text = "再次绘制解锁图案"
            return true
        }else{
            if(result == previousString){
                gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
                gesturePasswordView.state!.text = "已保存手势密码"
                if delegate != nil {
                    delegate?.changeGesturePwd(1)
                }
                backFunc()
                return true;
            }else{
                gesturePasswordView.tentacleView!.enterArgin()
                gesturePasswordView.state!.textColor = UIColor.redColor()
                gesturePasswordView.state!.text = "与上次绘制不一致，请重新绘制"
                return false
            }
        }
    }
    
    //MARK: - 改变手势密码
    func change(){
        previousString = ""
        gesturePasswordView.tentacleView!.enterArgin()
        gesturePasswordView.state!.textColor = UIColor.redColor()
        gesturePasswordView.state!.text = "重新绘制解锁图案"
    }
    
    //MARK: - 忘记密码
    func forget(){
        print("忘记密码")
    }
    
    //点击左按钮触发事件
    func clickLeftBtnEventGesturePwd() {
        backFunc()
    }
    
    func backFunc(){
        if navigationController != nil {
            navigationController?.popViewControllerAnimated(true)
        }else{
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
