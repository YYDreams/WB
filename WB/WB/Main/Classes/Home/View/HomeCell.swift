//
//  HomeCell.swift
//  WB
//
//  Created by flowerflower on 2018/9/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit
import SDWebImage
private let magin: CGFloat = 15
class HomeCell: UITableViewCell {
    //头像
    @IBOutlet weak var iconImageView: UIImageView!
    // 用户认证
    @IBOutlet weak var verifiedImageView: UIImageView!
    //昵称
    @IBOutlet weak var nameLabel: UILabel!
    // vip
    @IBOutlet weak var vipImageView: UIImageView!
    //创建时间
    @IBOutlet weak var created_atLabel: UILabel!
    //来源
    @IBOutlet weak var sourceLabel: UILabel!
    //正文
    @IBOutlet weak var contentTextLabel: UILabel!
    //正文的宽度
    @IBOutlet weak var contentWidthConst: NSLayoutConstraint!

    //
    var viewModel: HomeViewModel? {
        
        didSet{
            
            // 1.nil值校验
            guard let viewModel = viewModel else {
                return
            }
            //2.赋值
            //2.1 头像
            let url =  URL(string: (viewModel.status?.user?.profile_image_url ?? ""))
            iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named:"avatar_default_big"))

            
            //2.2 认证
            verifiedImageView.image = viewModel.verifiedImage
            
            //2.3 昵称
            nameLabel.text = viewModel.status?.user?.screen_name
            nameLabel.textColor = (viewModel.vipImage == nil) ? UIColor.black : UIColor.orange
            
            //2.4 会员图标
            vipImageView.image = viewModel.vipImage
            //2.5 时间
             created_atLabel.text = viewModel.created_atText
            //2.6 来源
            sourceLabel.text = viewModel.sourceText
            
            //2.7  正文
            contentTextLabel.text = viewModel.status?.text

        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()

       contentWidthConst.constant = screenW - 2 * magin
 
    }

}
