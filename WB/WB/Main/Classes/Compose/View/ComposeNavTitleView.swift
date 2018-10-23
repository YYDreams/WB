//
//  ComposeNavTitleView.swift
//  WB
//
//  Created by flowerflower on 2018/10/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SnapKit

class ComposeNavTitleView: UIView {
    
    //    private lazy var tipLabel: UILabel = UILabel() //
    private lazy var titleLabel:UILabel = UILabel()
    private lazy var screenNameLabel:UILabel = UILabel()
 //构造函数
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ComposeNavTitleView{
    
    private func setupSubView(){
        
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(-20)
            
        }
    
        screenNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        screenNameLabel.font = UIFont.systemFont(ofSize: 13)
        screenNameLabel.textColor = UIColor.lightGray
        titleLabel.text = "发微博"
        screenNameLabel.text =  UserAccount.loadAccount()?.screen_name
        
    }
    
    
    
}

