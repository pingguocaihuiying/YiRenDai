//
//  GesturePasswordView.swift
//  GesturePassword4Swift
//
//  Created by feiin on 14/11/22.
//  Copyright (c) 2014年 swiftmi. All rights reserved.
//

import UIKit

protocol GesturePasswordDelegate
{
    func forget()
    func change()
    func clickLeftBtnEventGesturePwd()
}

class GesturePasswordView: UIView,TouchBeginDelegate {

    var tentacleView:TentacleView?
    
    var state:UILabel?
    
    var gesturePasswordDelegate:GesturePasswordDelegate?
    
    var imgView:UIImageView?
    
    var forgetButton:UIButton?
    
    var changeButton:UIButton?
    
    private var buttonArray:[GesturePasswordButton]=[]
    
    private var lineStartPoint:CGPoint?
    private var lineEndPoint:CGPoint?

    private var topView:UIView!
    private var titleLbl:UILabel!
    private var leftBtn:UIButton!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Initialization code
        
        initTopView()
      
        let view = UIView(frame:CGRectMake(frame.size.width/2-160, frame.size.height/2-80, 320, 320))
        
        for i in 0..<9 {
            
            let row = Int(i/3)
            let col = Int(i%3)
            
            let distance = Int(320/3)
            let size:Int = Int(Float(distance)/1.5)
            let margin = Int(size/4)
            
            let gesturePasswordButton = GesturePasswordButton(frame: CGRectMake(CGFloat(col*distance+margin), CGFloat(row*distance), CGFloat(size), CGFloat(size)))
            
            gesturePasswordButton.tag = i
            
            view.addSubview(gesturePasswordButton)
            buttonArray.append(gesturePasswordButton)
            
        }
        
        
        self.addSubview(view)
        
        tentacleView = TentacleView(frame: view.frame)
  
        tentacleView!.buttonArray = buttonArray
        tentacleView!.touchBeginDelegate = self
        self.addSubview(tentacleView!)
        
        state = UILabel(frame: CGRectMake(frame.size.width/2-140, frame.size.height/2-120, 280, 30))
        state!.textAlignment = NSTextAlignment.Center
        state!.font = UIFont.systemFontOfSize(14)
        self.addSubview(state!)
        
        imgView = UIImageView(frame:CGRectMake(frame.size.width/2-35, frame.size.width/2-80, 70, 70))
        imgView?.backgroundColor = UIColor.whiteColor()
        imgView?.image = UIImage(named: "acc_yrb_y")
        imgView!.layer.cornerRadius = 35
        self.addSubview(imgView!)
        
        forgetButton = UIButton(frame:CGRectMake(frame.size.width/2-150, frame.size.height/2+220, 120, 30))
        forgetButton!.titleLabel?.font = UIFont.systemFontOfSize(14)
        forgetButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        forgetButton!.setTitle("忘记手势密码", forState: UIControlState.Normal)
        forgetButton!.addTarget(self, action: #selector(GesturePasswordView.forget), forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(forgetButton!)
        
        changeButton = UIButton(frame:CGRectMake(frame.size.width/2+30, frame.size.height/2+220, 120, 30))
        changeButton!.titleLabel?.font = UIFont.systemFontOfSize(14)
        changeButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        changeButton!.setTitle("修改手势密码", forState: UIControlState.Normal)
        changeButton!.addTarget(self, action: #selector(GesturePasswordView.change), forControlEvents: UIControlEvents.TouchDown)
        self.addSubview(changeButton!)
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)!
    }
    
    func initTopView(){
        //topView
        topView = UIView(frame: CGRectMake(0, 0, screen_width, top_height))
        topView.backgroundColor = UIColor(red:0.99, green:0.33, blue:0.17, alpha:1.00)
        self.addSubview(topView)
        //lblTitle
        titleLbl = UILabel(frame: CGRectMake(0, statusBar_height, screen_width, navigationBar_height))
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.textColor = UIColor.whiteColor()
        self.addSubview(titleLbl)
        //btnLeft
        leftBtn = UIButton(frame: CGRectMake(14, statusBar_height, 50, navigationBar_height))
        leftBtn.titleLabel?.textColor = UIColor.whiteColor()
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        leftBtn.setImage(UIImage(named: "left"), forState: .Normal)
        leftBtn.addTarget(self, action: #selector(GesturePasswordView.clickLeftBtnEventGesturePwd), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(leftBtn)
    }
    
    //设置lblTitle文本
    func setTopViewTitle(title:String){
        titleLbl.text = title
    }
    
    //点击左按钮触发事件
    func clickLeftBtnEventGesturePwd(){
        if(gesturePasswordDelegate != nil){
            gesturePasswordDelegate!.clickLeftBtnEventGesturePwd()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext();
        
        var rgb = CGColorSpaceCreateDeviceRGB();
        var colors:[CGFloat] = [134/255,157/255,147/255,1.0,3/255,3/255,37/255,1.0]
      
        var  nilUnsafePointer:UnsafePointer<CGFloat> = nil
        
        var gradient = CGGradientCreateWithColorComponents(rgb, colors, nilUnsafePointer,2)
        
        CGGradientDrawingOptions()
        
        //CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0), CGPointMake(0.0, self.frame.size.height), 0)
    }
    
    
    func gestureTouchBegin(){
        
        self.state!.text = ""
    }
    
    
    func forget(){
        if(gesturePasswordDelegate != nil){
            gesturePasswordDelegate!.forget()
        }
    }
    
    func change(){
        if(gesturePasswordDelegate != nil){
            gesturePasswordDelegate!.change()
        }
    }

}
