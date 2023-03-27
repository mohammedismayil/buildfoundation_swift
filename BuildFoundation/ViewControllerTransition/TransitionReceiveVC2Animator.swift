//
//  TransitionReceiveVC2Animator.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 26/03/23.
//

import Foundation
import UIKit

enum AnimationType {
    case present
    case dismiss
}

class TransitionReceiveVC2Animator:  NSObject,UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval {
        switch animationType {
        
        case .dismiss:
            return 5
        case .present:
            return 1
        }
    }
    let delay: TimeInterval = 1
    
    var animationType:AnimationType
    
    public init(type:AnimationType) {
        self.animationType = type
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let duration: TimeInterval = 5
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        print("Animate transition triggered")
        
    
        switch animationType {
        case .present:
            presentAnimation(transitionContext: transitionContext)
        case .dismiss:
            dismissAnimation(transitionContext: transitionContext)
        }
      
        
    }
    
    func presentAnimation(transitionContext:UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view,let toViewSnapshot = toView.snapshotView(afterScreenUpdates: true),let toVC = transitionContext.viewController(forKey: .to) as? TransitionReceiveVC2, let fromVC = transitionContext.viewController(forKey: .from) as? TransitionReceiveVC ,let fromViewSnapShot = fromVC.placeImageView.snapshotView(afterScreenUpdates: true) else{
            
                transitionContext.completeTransition(false)
            return
        }
        
        let center = toView.center
        container.backgroundColor = .clear
//        fromVC.view.backgroundColor = .clear
        container.addSubview(toView)
        toVC.avatarImage.isHidden = true
        container.addSubview(fromViewSnapShot)
        fromViewSnapShot.frame = fromVC.placeImageView.frame
        toView.alpha = 1
        toViewSnapshot.frame = fromViewSnapShot.frame
        let scaleToFitInialState = fromVC.placeImageView.frame.width / toView.bounds.width
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let translate = CGAffineTransform(translationX: 100, y: -150)
        toView.center = CGPoint(x: fromVC.placeImageView.frame.maxX, y: fromVC.placeImageView.frame.maxY)
        toView.transform = scale
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = toVC.avatarImage.frame
            toView.center = center
            toView.transform = .identity
        },completion: { (success) in
            container.backgroundColor = .clear
            toView.alpha = 1
            toVC.avatarImage.isHidden = false
            toViewSnapshot.removeFromSuperview()
            fromViewSnapShot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
       
        
    }
    
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view,let toViewSnapshot = toView.snapshotView(afterScreenUpdates: true),let toVC = transitionContext.viewController(forKey: .to) as? TransitionReceiveVC, let fromVC = transitionContext.viewController(forKey: .from) as? TransitionReceiveVC2 , let fromViewSnapShot = fromVC.avatarImage.snapshotView(afterScreenUpdates: true),let fromControlSnapShot = fromVC.view.snapshotView(afterScreenUpdates: true) else{
            
                transitionContext.completeTransition(false)
            return
        }
        
        let center = toView.center
        container.addSubview(toView)
        toVC.placeImageView.isHidden = true
        fromViewSnapShot.frame = fromVC.avatarImage.frame
        fromVC.avatarImage.isHidden = true
        toView.alpha = 1
        let scaleToFitInialState = toVC.placeImageView.frame.width / toView.bounds.width
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        let translate = CGAffineTransform(translationX: 100, y: -150)
        container.addSubview(fromControlSnapShot)
        container.addSubview(fromViewSnapShot)
        fromControlSnapShot.frame = fromVC.view.frame
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = toVC.placeImageView.frame
            fromControlSnapShot.center = toVC.placeImageView.frame.center
            fromControlSnapShot.transform = scale
        },completion: { (success) in
            fromVC.avatarImage.isHidden = false
            toVC.placeImageView.isHidden = false
            toViewSnapshot.removeFromSuperview()
            fromViewSnapShot.removeFromSuperview()
            fromControlSnapShot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
       
        
    }
    
}
