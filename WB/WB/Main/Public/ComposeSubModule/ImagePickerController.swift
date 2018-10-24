//
//  ImagePickerController.swift
//  WB
//
//  Created by flowerflower on 2018/10/24.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class ImagePickerController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate

    }

}
/** 注意:
 必须遵守 UINavigationControllerDelegate 否则会报错
 
 info:["UIImagePickerControllerImageURL": file:///Users/flowerflower/Library/Developer/CoreSimulator/Devices/EEA3BA08-6B8D-46DE-B3B5-DEE7BA8D8598/data/Containers/Data/Application/C8DFF21D-6ABD-4601-9A8E-CAF6072582E3/tmp/9A048BD3-30CA-4D92-861B-AAC6FF61DE9C.jpeg, "UIImagePickerControllerMediaType": public.image, "UIImagePickerControllerReferenceURL": assets-library://asset/asset.JPG?id=B84E8479-475C-4727-A4A4-B77AA9980897&ext=JPG, "UIImagePickerControllerOriginalImage": <UIImage: 0x6040002a0840> size {4288, 2848} orientation 0 scale 1.000000]
 */
extension  ImagePickerController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("info:\(info)")
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        
        
    }
    
}
