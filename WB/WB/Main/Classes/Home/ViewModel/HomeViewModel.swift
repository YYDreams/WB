//
//  HomeViewModel.swift
//  WB
//
//  Created by flowerflower on 2018/9/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

//MARK: 处理数据
class HomeViewModel: NSObject {
        
    //定义属性
    var status: HomeStatusModel?
    
    // MARK: - 对数据处理
    var sourceText: String? //处理来源
    
    var created_atText:String?  //处理创建时间
    
    var verifiedImage:UIImage?   //处理用户认证图标
    
    var vipImage:UIImage?  //处理用户会员等级
    
    var pirUrls: [NSURL] = [NSURL]() //处理微博配图数据
    
    var cellHeight: CGFloat = 0
    //自定义构造函数
    init(status : HomeStatusModel) {
        
       self.status = status

        //1>  处理来源
        
        //1. nil值校验
        //guard中  不支持&&   例如: guard let source = source  &&  source != "" else {
        //3.0 中是 用 where   例如guard let source = source where source != ""  else {
        
        if let source = status.source, source != ""   {
            //2.对来源的字符串进行处理
            //            "source":"<a href="http://app.weibo.com/t/feed/1Kd4aA" rel="nofollow">微博 weibo.com</a>",
            //从前往后开始截取
            //2.1 获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length  = (source  as NSString).range(of: "</").location - startIndex
            //2.2 截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))

        }
        
        //2>  处理时间
        if let createAt = status.created_at {
            
            created_atText = NSDate.dateWithStr(time: createAt) as String
            
        }
        //3>  处理用户认证图标
        let verfiedType = status.user?.verified_type ?? -1
       
        switch verfiedType {
        case 0:
            verifiedImage = UIImage(named:"avatar_vip")
        case 2,3,4:
            verifiedImage = UIImage(named:"avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named:"avatar_grassroot")
        default:
            verifiedImage = nil
            
        }
        //4>  处理用户会员等级
        let mbrank = status.user?.mbrank ?? 0
        
        if mbrank > 0 && mbrank < 7 {
            vipImage = UIImage(named: "common_icon_membership_level"+"\(mbrank)")
            
        }
        
        //5> 处理微博配图数据
        let  picUrlDicts = status.pic_urls?.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        if let picUrlDicts = picUrlDicts{
            for picUrlDic  in picUrlDicts {
                
            guard  let picUrlStr = picUrlDic["thumbnail_pic"] else {
     
                continue
                
                }
                //到这步是一定有值的  可以强制解包
                pirUrls.append(NSURL(string:picUrlStr)!)
            }
        }
    }
}

//MARK: request Data
extension HomeViewModel {

    /**
     [[String :AnyObject]]   数组字典类型 且数组里面存放的是字典
     
     since_id: 最新数据   max_id 更多数据
     */
    
    class  func loadStatusFromNetwork(since_id : Int ,max_id: Int,findished:@escaping ( _ result:[[String :AnyObject]]? ,_ error: Error?)->()){
        
        let param = ["access_token":(UserAccount.loadAccount()?.access_token)!,"since_id":"\(since_id)","max_id":"\(max_id)"]
        
        NetworkTool.shareNetworkTool().request(methodType: .GET, urlString: kStatusesHomeUrl, parameters: param as [String : AnyObject]) { (result, error) in
            
            if error != nil {
                print("error:\(String(describing: error))")
                return
            }
            
            //1.获取 字典的数据
            guard  let resultDic  = result as? [String : AnyObject] else{
                findished(nil, error)
                return
            }
            //2.将数组数据回调给外界
            findished(resultDic["statuses"] as? [[String: AnyObject]], error)
        }
    }
    
}
