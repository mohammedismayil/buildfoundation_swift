//
//  TransitionReceiveVC2.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 25/03/23.
//

import Foundation
import UIKit

class TransitionReceiveVC2Animator:  NSObject,UIViewControllerAnimatedTransitioning {
    
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
        fromViewSnapShot.frame = fromVC.placeImageView.frame
        toView.alpha = 0
        let duration: TimeInterval = 2
        let delay: TimeInterval = 1
        
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = CGRect(x: 20, y: 100, width: 50, height: 50)
        },completion: { (success) in
            toView.alpha = 1
            transitionContext.completeTransition(true)
        })
       
        
        
    }
    
    
    
}
class TransitionReceiveVC2: UIViewController {
    
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
