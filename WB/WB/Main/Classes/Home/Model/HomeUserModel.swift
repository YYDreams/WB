//
//  HomeUserModel.swift
//  WB
//
//  Created by flowerflower on 2018/9/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
@objcMembers
class HomeUserModel: NSObject {
    
    var profile_image_url: String?  //用户头像

    // 用户认证的类型: -1 没有认证，0 认证用户，2、3、4 企业认证，220 达人
    var verified_type: Int = -1 {
        
        didSet{
            
//         switch verified_type {
//            case 0:
//                verified_Image = UIImage(named:"avatar_vip")
//            case 2,3,4:
//                verified_Image = UIImage(named:"avatar_enterprise_vip")
//            case 220:
//                verified_Image = UIImage(named:"avatar_grassroot")
//            default:
//                verified_Image = nil
//
//            }
        }
        
    }
    
    // 用户认证类型的图片
    var verified_Image: UIImage?
    var screen_name: String? //用户的昵称
    
    // 用户会员的等级mbrank
    var mbrank: Int = 0{
        
        didSet{
            
//            if mbrank > 0 && mbrank < 7
//            {
//                mbrankImage = UIImage(named: "common_icon_membership_level"+"\(mbrank)")
//                
//            }
        }
         
    }
    var mbrankImage: UIImage?
    
    // 自定义构造函数 字典转模型
    init( dict:[String :AnyObject]) {
        
        super.init()
        // 会调用 setValue forKey 给每一个属性赋值
        setValuesForKeys(dict)
        
    }
    // 这句话的意思是字典转模型的时候 要一一对应的，为了防止没有的字段崩溃，那么就跳过(没有的字段会走这里的，不用做什么操作就好了)
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
