//
//  HomeStatusModel.swift
//  WB
//
//  Created by flowerflower on 2018/9/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
@objcMembers
class HomeStatusModel: BaseModel {

    var created_at: String? {  //创建时间
        
        didSet{
//            guard let  created_at = created_at else {
//
//                return
//            }
//            created_atText = NSDate.dateWithStr(time: created_at) as String
        
        }
    }
    var source: String?{   // 来源
        didSet{      //相当于添加属性监听器
            
//            //1. nil值校验
//            //guard中  不支持&&   例如: guard let source = source  &&  source != "" else {
//            //3.0 中是 用 where   例如guard let source = source where source != ""  else {
//
//            guard let source = source, source != ""  else {
//                
//             return
//            }
//            //2.对来源的字符串进行处理
//            //            "source":"<a href="http://app.weibo.com/t/feed/1Kd4aA" rel="nofollow">微博 weibo.com</a>",
//            //从前往后开始截取
//            //2.1 获取起始位置和截取的长度
//             let startIndex = (source as NSString).range(of: ">").location + 1
//            let length  = (source  as NSString).range(of: "</").location - startIndex
//            //2.2 截取字符串
//            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))

        }

    }
    var text: String?           // 正文
    var mid: Int = 0            //微博的ID  上拉或者下拉需要
    
    
    var user: HomeUserModel? //对应的用户

    var pic_urls:[[String: String]]? //微博的配图
    
   var retweeted_status: HomeStatusModel? //微博对应的转发微博
    
    /**
     "pic_urls":[
     {
     "thumbnail_pic":"http://wx4.sinaimg.cn/thumbnail/63096b7bly1fvoeqp6p65j20m80m8na4.jpg"
     },
     {
     "thumbnail_pic":"http://wx1.sinaimg.cn/thumbnail/63096b7bly1fvoeqp6isrj20m80m8an5.jpg"
     },
     {
     "thumbnail_pic":"http://wx2.sinaimg.cn/thumbnail/63096b7bly1fvoeqp71ejj20m80m8tlf.jpg"
     }
     ],
     
     */

    // MARK: 自定义构造函数
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        
        //1.将用户字典转成用户模型对象
        if let userDic = dict["user"] as? [String: AnyObject]{
            user = HomeUserModel(dict: userDic)
            
            
        }
        //2.将转发微博字典转成转发微博模型对象
        if let retweetedStatus = dict["retweeted_status"] as? [String: AnyObject]{
            
            retweeted_status = HomeStatusModel(dict: retweetedStatus)
        }
        
        
    }
    
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
    }
}
