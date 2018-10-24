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
private let iteMagin: CGFloat = 10
class HomeCell: BaseCell {
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
    
     //转发微博的文字
    @IBOutlet weak var retweetedLabel: UILabel!
    //转发微博的文字宽度
    @IBOutlet weak var retweetedWidthConst: NSLayoutConstraint!
    //转发微博的背景
    @IBOutlet weak var retweetedBgView: UIView!
    //collectionView
    @IBOutlet weak var collectionView: PicCollectionView!
    // 配图的高度
    @IBOutlet weak var picViewHeightConst: NSLayoutConstraint!
    //collectionView底部距离底部工具栏的间距
    @IBOutlet weak var picViewBottomConst: NSLayoutConstraint!
    // 配图的宽度
    @IBOutlet weak var picViewWidthConst: NSLayoutConstraint!
    //转发微博正文距离顶部的距离
    @IBOutlet weak var retweetContentLabelTopConst: NSLayoutConstraint!
    // 底部工具条的View
    @IBOutlet weak var bottomView: UIView!
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
            if let sourceText = viewModel.sourceText {
            sourceLabel.text = "来自 " + sourceText
            }else{
                sourceLabel.text = nil //防止循环利用
            }
            
            
            //2.7  正文
            contentTextLabel.text = viewModel.status?.text
            
            //2.8 计算配图高度的约束
            let picViewSize  = calculatePicViewSize(count: viewModel.pirUrls.count)
            picViewWidthConst.constant = picViewSize.width
            picViewHeightConst.constant = picViewSize.height
            
            print(picViewSize)
            
            collectionView.picUrls = viewModel.pirUrls
            
            //2.9 设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name,
                   let retweetedText = viewModel.status?.retweeted_status?.text {
                    retweetContentLabelTopConst.constant = 10
                    retweetedLabel.text = "@" + "\(screenName)" + retweetedText
                    
                    retweetedBgView.isHidden = false
                }
            } else{
                retweetedLabel.text = nil
                retweetedBgView.isHidden = true
                //无转发微博 则设置为 0
                retweetContentLabelTopConst.constant = 0
            }

            //注意：如需手动计算 则需要去除底部约束
            if viewModel.cellHeight == 0 {  // 如果从没有计算过 才需要计算
                   layoutIfNeeded()
           viewModel.cellHeight = (bottomView.frame).maxY  //手动计算cell的高度 并将高度保存到viewModel模型中
            }

        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()

        //设置正文的约束
       contentWidthConst.constant = screenW - 2 * magin
        retweetedWidthConst.constant = screenW - 2 * magin
        
        // 单张图片需要特殊处理 则统一在 calculatePicViewSize进行处理
//       // 取出picView对应的layout
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        let imageViewWH = (screenW - 2 * magin - 2 * iteMagin)/3
//
//        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
      
    }

}

extension HomeCell{
    
    private func calculatePicViewSize(count: Int) -> CGSize  {
        /**
         注意约束冲突 当count == 0  距离正文10  距离toolTabar 10
         解决措施 修改collectionView的优先级Priority 700
         则会选用优先级高的约束  优先级低的约束则不会生效
         */
        
        /**
         图片显示分几种情况:
         1.没有配图
         2.单张配图
         3.4张配图
         4.其他张配图 (count -1)/3 + 1  = rows
   */
        
        //1.没有配图
        if count == 0 {
            picViewBottomConst.constant = 0

            return CGSize(width: 0, height: 0)
        }
        //有配图下改约束
        picViewBottomConst.constant = 10
        // 取出picView对应的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        //2.单张配图 官方文档并没有返回对应的宽高度
        //要想做的话 需要将图片下载下来  再拿图片的宽度和高度  最后展示
        if count == 1 {
            //取出图片
            let picUrlStr = viewModel?.pirUrls.first?.absoluteString
            //从磁盘中取出下载的图片
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picUrlStr)
            //有点问题 显示得有点小  微调 *2
            layout.itemSize = CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
            return CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
        }

        //图片的WH
        let imageViewWH = (screenW - 2 * magin - 2 * iteMagin)/3
        
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        //3.4张配图
        if  count == 4 {
            
            let picViewWH = imageViewWH * 2 +  iteMagin + 1  //+1微调
            
            return CGSize(width: picViewWH, height: picViewWH)
        }
  
         // 4.其他张配图 (count -1)/3 + 1  = rows
        /**
         例子:  5张配图  2行   row:(5-1)/3+1 = 2  H: 2 *
         */
         // 4.1 计算行数
        let rows = CGFloat( (count - 1 )/3 + 1)
        //  4.2 计算高度
        let picViewH = rows * imageViewWH + (rows - 1 ) * iteMagin
        //  4.3 计算宽度
        let picViewW = screenW - 2 * magin
        
        return CGSize(width: picViewW, height: picViewH)

      
    }

    
}

