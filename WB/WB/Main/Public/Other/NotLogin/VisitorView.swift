//
//  VisitorView.swift
//  WB
//
//  Created by flowerflower on 2018/2/2.
//  Copyright © 2018年 花花. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    
    class func visitorView() -> VisitorView{
        
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.last  as! VisitorView
        
    }
    
    
    @IBOutlet weak var rotationImageView: UIImageView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var registBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    func setVisitorInfo(iconImageName:String,title:String){
        
        self.iconImageView.image = UIImage(named:iconImageName)
        self.tipLabel.text = title
        rotationImageView.isHidden = true
        
    }
 
    func addRotationAnimation(){
        
        //1.创建动画
        let rotationAnomation = CABasicAnimation(keyPath: "transform.rotation.z")
        //2.设置动画的属性
        rotationAnomation.fromValue = 0 //开始位置
        
        rotationAnomation.toValue =  M_PI * 2
        rotationAnomation.duration = 5
        rotationAnomation.repeatCount = MAXFLOAT
        //默认为YES 如果不设置这个 去到别的地方再回来 则不转了
        rotationAnomation.isRemovedOnCompletion = false //
        
        //3.添加动画到layer中
        rotationImageView.layer.add(rotationAnomation, forKey: nil)
        
    }
    
 
}
