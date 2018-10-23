//
//  ComposeTextView.swift
//  WB
//
//  Created by flowerflower on 2018/10/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {

     lazy var placeHolderLabel:UILabel = UILabel()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        setupSubView()
    }
    
    
    private func setupSubView(){
        
        addSubview(placeHolderLabel)
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
            
        }
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事"
        //左边多少 右边多少
        textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8)
        
        
    }
    

}




