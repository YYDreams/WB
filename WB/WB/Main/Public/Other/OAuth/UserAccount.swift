//
//  UserAccount.swift
//  WB
//
//  Created by flowerflower on 2018/9/21.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
@objcMembers
class UserAccount: NSObject,NSCoding{
    
    
    class func userLogin() -> Bool{
        
        return UserAccount.loadAccount() != nil
    }
    
    // 1.用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据，第三方应用应该用该票据和自己应用内的用户建立唯一影射关系，来识别登录状态，不能使用本返回值里的UID字段来做登录识别。
    var access_token: String?
    // 2.access_token的生命周期，单位是秒数。
    var expires_in: NSNumber?{
        // 只要expires_in被赋值，就会调用didSet
        didSet{
            // 根据过期的秒数，真正的生成过期的时间
            expires_date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
            
            print("过期时间\(expires_date!)")
        }
        
}
    // 6.保存用户的过期时间
    var expires_date : NSDate?
    
    // 3.授权用户的UID，本字段只是为了方便开发者，减少一次user/show接口调用而返回的，第三方应用不能用此字段作为用户登录状态的识别，只有access_token才是用户授权的唯一票据。
    var uid: String?
    // 4.用户头像地址（大图），180×180像素
    var avatar_large: String?
    // 5.用户的昵称 screen_name
    var screen_name: String?
    
    override init() {
        
    }
    
    
    
    init(dic: [String:AnyObject]) {
        
        super.init()
        setValuesForKeys(dic)
    }
    
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        print(key)
    }
    
    override var description: String{
        
        // 1.定义属性数组
        let properties = ["access_token","expires_in","uid","avatar_large","screen_name","expires_date"]
        // 2.根据属性数组，把属性数组转化为字典
        let dic = self.dictionaryWithValues(forKeys: properties)
        // 3.将字典转化为字符串
        return "\(dic)"
    }
    
    
    
    
    
    func loadUserInfo(finished: @escaping (_ account : UserAccount?,_ error:NSError?)->()){
        
        assert(access_token != nil, "没有授权")
        let params = ["access_token":access_token,"uid":uid]
        
        NetworkTool.shareNetworkTool().get(kUserShowUrl, parameters: params, progress: nil, success: { (_, json) in
            
            
            print("kUserShowUrl:\(json!)")
            
            
            if let dic = json as? [String : AnyObject] {
                
                self.screen_name = dic["screen_name"] as? String
                self.avatar_large = dic["avatar_large"] as? String
                
                finished(self, nil)
                return
            }
            finished(self, nil)
            
 
        }) { (_, error) in
        
            
            
        }
        
        
        
    }
    
    
    //将account对象保存
         // 1.获取沙盒路径
    static let filePath =  NSHomeDirectory() + "/Library/Caches" + "/account.plist"
    func saveAccount(){
        //  2.将对象写入到文件中(归档) NSKeyedArchiver
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)

    }
    
    
    static var account: UserAccount?
    class func loadAccount() -> UserAccount? {
        
        // 1.判断是否已经进行加载过

        if account != nil {
            return account
        }
        // 2.如果没有加载过，进行加载

        account = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.filePath) as? UserAccount
        // 3.判断授权信息是否过期
        // 授权的时间 2022-11-09 00:44:30 +0000 2022-11-10 00:44:30 +0000

        if account?.expires_date?.compare(NSDate() as Date) ==   ComparisonResult.orderedAscending {
          
        return nil
        }
        return account
    }
    

    
    //MARK:- 归档 & 接档
    //归档
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(access_token, forKey:"access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
    //解档
    required init?(coder aDecoder: NSCoder)
    {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_in = aDecoder.decodeObject(forKey: "expires_in") as? NSNumber
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
}
extension UserAccount{
    

    
    
    
}

