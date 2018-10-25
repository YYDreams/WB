

//
//  PhotoBrowserAnimator.swift
//  WB
//
//  Created by flowerflower on 2018/10/25.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

import UIKit

class PhotoBrowserAnimator: NSObject {

    var isPresent: Bool = false
    
    
}

extension  PhotoBrowserAnimator:UIViewControllerTransitioningDelegate{
    

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
        
    }

}

extension PhotoBrowserAnimator:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresent ?  animationForPressent(transitionContext: transitionContext) : animationForDismissed(transitionContext: transitionContext )

    }
    
   private  func animationForPressent( transitionContext: UIViewControllerContextTransitioning){
        
        
        let pressentView = transitionContext.view(forKey:UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(pressentView)
        
        
        pressentView.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext) , animations: {
            
            pressentView.alpha = 1.0
            
        }) { (_) in
            
            transitionContext.completeTransition(true)
        }
    }
    
 private   func animationForDismissed( transitionContext: UIViewControllerContextTransitioning){
    
     let dismissed = transitionContext.view(forKey: UITransitionContextViewKey.from)!
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext) , animations: {
        
        dismissed.alpha = 0.0
        
    }) { (_) in
        
        dismissed.removeFromSuperview()
        
    }
        
  }
    
}



