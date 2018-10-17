//
//  WelcomeController.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

import SDWebImage
@objcMembers
class WelcomeController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        let icon  = UserAccount.loadAccount()?.avatar_large;
        /**
         ?? 如果？？前面的可选类型有值 那么将前面的可选类型进行解包并赋值
          如果前面的可选类型为nil 那么直接使用？？后面的值
         */
        let url = URL(string: icon ?? "")
   
        
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named:"avaar_default_big"))
        iconViewBottomConstant.constant = screenH - 200
        //Damping 阻力系数   阻力系数越大  弹力的效果越不明显
        //SpringVelocity 初始化速度
        //
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            
            self.view.layoutIfNeeded()

        }) { (_) in
            
            
            UIApplication.shared.keyWindow?.rootViewController = BaseTabBarViewController()
            
            
        }
        
        
    }
    

}
