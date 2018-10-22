//
//  PicCell.swift
//  WB
//
//  Created by flowerflower on 2018/10/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class PicCell: UICollectionViewCell {

    var picUrl: NSURL?{
        didSet{
            guard let picUrl = picUrl else {
                
                return
            }
            
            picImageView.sd_setImage(with: picUrl as URL, placeholderImage:  UIImage(named:"empty_picture"))
            
        }
        
    }
    @IBOutlet weak var picImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
