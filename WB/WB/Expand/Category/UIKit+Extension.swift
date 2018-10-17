//
//  UIKit+Extension.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

protocol LoadViewFromNib {}

extension LoadViewFromNib{
    
    static func loadViewFromNib() -> Self {
        
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
    
}


