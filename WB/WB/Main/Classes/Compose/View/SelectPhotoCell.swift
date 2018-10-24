//
//  SelectPhotoCell.swift
//  WB
//
//  Created by flowerflower on 2018/10/24.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class  SelectPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoButtton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deletePhotoButton: UIButton!
    
    var image : UIImage?{
        didSet{
            
            if image != nil  {
                
                photoButtton.isUserInteractionEnabled = false
                deletePhotoButton.isHidden = false
                photoImageView.image = image
                
            }else{
                photoButtton.isUserInteractionEnabled = true
                deletePhotoButton.isHidden = true
                photoImageView.image = nil
                
            }
       
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    @IBAction func addPhotoOnClick() {
        

         //多级传递，才用通知
   
        NotificationCenter.default.post(name: NSNotification.Name(kSelectPhotoNotification), object: nil)
        
        
        
    }
    
    @IBAction func deletePhotoOnClick() {
        
        NotificationCenter.default.post(name: NSNotification.Name(kDeletePhotoNotification), object: photoImageView.image)

    }
    
    
    
}
