//
//  TransitionReceiveVC2Animator.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 26/03/23.
//

import Foundation
import UIKit

class TransitionReceiveVC2Animator:  NSObject,UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 5
    let delay: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let duration: TimeInterval = 5
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        print("Animate transition triggered")
        
    
        
        let container = transitionContext.containerView
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view,let toViewSnapshot = toView.snapshotView(afterScreenUpdates: true),let toVC = transitionContext.viewController(forKey: .to) as? TransitionReceiveVC2, let fromVC = transitionContext.viewController(forKey: .from) as? TransitionReceiveVC ,let fromViewSnapShot = fromVC.placeImageView.snapshotView(afterScreenUpdates: true) else{
            
                transitionContext.completeTransition(false)
            return
        }
        
        
       
        container.addSubview(toView)
        container.addSubview(fromViewSnapShot)
        container.addSubview(toViewSnapshot)
        fromViewSnapShot.frame = fromVC.placeImageView.frame
        toView.alpha = 0
        toViewSnapshot.frame = fromViewSnapShot.frame
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = toVC.avatarImage.frame
//            toViewSnapshot.frame = toVC.view.frame
//            toViewSnapshot.transform = CGAffineTransform(scaleX: 2, y: 2)
        },completion: { (success) in
            toView.alpha = 1
            toViewSnapshot.removeFromSuperview()
            fromViewSnapShot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
       
        
        
    }
    
    
    
}
