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
    
    let duration: TimeInterval = 5
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
        fromVC.view.backgroundColor = .clear
        container.addSubview(toView)
        toVC.avatarImage.isHidden = true
        container.addSubview(fromViewSnapShot)
//        container.addSubview(toViewSnapshot)
        fromViewSnapShot.frame = fromVC.placeImageView.frame
//        toView.frame.height = fromVC.placeImageView.frame.height
        toView.alpha = 1
        toViewSnapshot.frame = fromViewSnapShot.frame
//        toView.center = transitionCenter
        let scaleToFitInialState = fromVC.placeImageView.frame.width / toView.bounds.width
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let translate = CGAffineTransform(translationX: 100, y: -150)
//        toView.transform = scale.concatenating(translate)
        
        toView.center = CGPoint(x: fromVC.placeImageView.frame.maxX, y: fromVC.placeImageView.frame.maxY)
//        toView.frame.height = 50
        toView.transform = scale
//        toView.transform = CGAffineTransform(scaleX: scaleToFitInialState, y: scaleToFitInialState)
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = toVC.avatarImage.frame
            toView.center = center
//            toView.frame.height = UIScreen.main.bounds.height
            toView.transform = .identity
//            toViewSnapshot.frame = toVC.view.frame
//            toViewSnapshot.transform = CGAffineTransform(scaleX: 2, y: 2)
        },completion: { (success) in
            container.backgroundColor = .clear
            toView.alpha = 1
//            toView.frame.height = UIScreen.main.bounds.height
            toVC.avatarImage.isHidden = false
            toViewSnapshot.removeFromSuperview()
            fromViewSnapShot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
       
        
    }
    
    func dismissAnimation(transitionContext:UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        
        guard let toView = transitionContext.viewController(forKey: .to)?.view,let toViewSnapshot = toView.snapshotView(afterScreenUpdates: true),let toVC = transitionContext.viewController(forKey: .to) as? TransitionReceiveVC2, let fromVC = transitionContext.viewController(forKey: .from) as? TransitionReceiveVC ,let fromViewSnapShot = fromVC.placeImageView.snapshotView(afterScreenUpdates: true) else{
            
                transitionContext.completeTransition(false)
            return
        }
        
        let center = toView.center
        container.backgroundColor = .clear
        fromVC.view.backgroundColor = .clear
        container.addSubview(toView)
        toVC.avatarImage.isHidden = true
        container.addSubview(fromViewSnapShot)
//        container.addSubview(toViewSnapshot)
        fromViewSnapShot.frame = fromVC.placeImageView.frame
//        toView.frame.height = fromVC.placeImageView.frame.height
        toView.alpha = 1
        toViewSnapshot.frame = fromViewSnapShot.frame
//        toView.center = transitionCenter
        let scaleToFitInialState = fromVC.placeImageView.frame.width / toView.bounds.width
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let translate = CGAffineTransform(translationX: 100, y: -150)
//        toView.transform = scale.concatenating(translate)
        
        toView.center = CGPoint(x: fromVC.placeImageView.frame.maxX, y: fromVC.placeImageView.frame.maxY)
//        toView.frame.height = 50
        toView.transform = scale
//        toView.transform = CGAffineTransform(scaleX: scaleToFitInialState, y: scaleToFitInialState)
        UIView.animate(withDuration: duration, delay: delay, animations: {
            fromViewSnapShot.frame = toVC.avatarImage.frame
            toView.center = center
//            toView.frame.height = UIScreen.main.bounds.height
            toView.transform = .identity
//            toViewSnapshot.frame = toVC.view.frame
//            toViewSnapshot.transform = CGAffineTransform(scaleX: 2, y: 2)
        },completion: { (success) in
            container.backgroundColor = .clear
            toView.alpha = 1
//            toView.frame.height = UIScreen.main.bounds.height
            toVC.avatarImage.isHidden = false
            toViewSnapshot.removeFromSuperview()
            fromViewSnapShot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
       
        
    }
    
}
