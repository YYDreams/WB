//
//  Progress.swift
//  WB
//
//  Created by flowerflower on 2018/10/25.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class Progress: UIView {

    
    var progress: CGFloat = 0{
        
        didSet{
            
            print("progress\(progress)")
            
            setNeedsDisplay()
            
            

        }
        
    }
    

    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        
        let center = CGPoint(x: rect.width * 0.5 , y: rect.height * 0.5 )
        let radius  = rect.width * 0.5 - 3
        let startAngle = CGFloat( -Double.pi/2)
        let endAngle = CGFloat(2 * Double.pi) * progress + startAngle
        
       let path =  UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.addLine(to: center)
        
        path.close()
        
        UIColor(white: 1.0, alpha: 0.4).setFill()
        
        
        path.fill() //开始绘制
    }
 

}
