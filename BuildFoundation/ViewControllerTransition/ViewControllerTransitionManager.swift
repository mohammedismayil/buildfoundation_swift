//
//  ViewControllerTransitionManager.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import Foundation
import UIKit

protocol TransitionManagerDelegate: AnyObject {
    func snapShotView()->UIView
}
class ViewControllerTransitionManager: NSObject,UIViewControllerTransitioningDelegate{

    var animator: ViewControllerTransition?
    var delegate: TransitionManagerDelegate?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        animator = ViewControllerTransition(type: .present, delegate: delegate)
            return animator
        }
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
 
            return nil
        }
    
}
class ViewControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    static let duration: TimeInterval = 4
    
    private let type: PresentationType
    var delegate: TransitionManagerDelegate?
    
    
    init?(type: PresentationType,delegate:TransitionManagerDelegate?) {
        self.type = type
        self.delegate = delegate
    }
 
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
     
        switch type {
        case .present:
            self.presentAnimation(using: transitionContext)
        case .dismiss:
            self.dismissAnimation(using: transitionContext)
        }
        
    }
    
    func performAnimation(duration: TimeInterval, spring: Bool = false, delay: TimeInterval = 0, _ block: @escaping ()->Void, completion: @escaping (Bool)->Void) {
        
        let commonAnimationOption: UIView.AnimationOptions = [.curveEaseInOut]
        
        
        UIView.animate(withDuration: duration, delay: 0, options: commonAnimationOption, animations: {
            block()
        }) { (success) in
            completion(success)
        }
        
        
    }
    
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard
            let vc = transitionContext.viewController(forKey: .from) as? TransitionCollectionViewViewController,
            let window = vc.view.window,
            let vc2 = transitionContext.viewController(forKey: .to) as? TransitionCollectionViewViewController2,
            let toView = vc2.view,
            let cellImageSnapshot = delegate?.snapShotView().snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = vc2.locationImageView.snapshotView(afterScreenUpdates: true),
            let cellImageViewRect =
                delegate?.snapShotView().convert(delegate?.snapShotView().bounds ?? CGRect(), to: window)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        let controllerImageViewRect = vc2.locationImageView.convert(vc2.locationImageView.bounds, to: window)
             
        containerView.addSubview(toView)
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = vc2.view.backgroundColor
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0
        toView.alpha = 0
        containerView.addSubview(backgroundView)
        containerView.addSubview(cellImageSnapshot)
        containerView.addSubview(controllerImageSnapshot)
        cellImageSnapshot.frame = cellImageViewRect
        cellImageSnapshot.alpha = 1
        controllerImageSnapshot.frame = cellImageViewRect
        controllerImageSnapshot.alpha = 0
        performAnimation(duration: Self.duration) {
            cellImageSnapshot.alpha = 0
            cellImageSnapshot.frame =  controllerImageViewRect
            controllerImageSnapshot.alpha = 1
            controllerImageSnapshot.frame =  controllerImageViewRect
            fadeView.alpha = 1
        } completion: { (success) in
            cellImageSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            toView.alpha = 1
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard
            let vc = transitionContext.viewController(forKey: .from) as? TransitionCollectionViewViewController,
            let window = vc.view.window,
            let vc2 = transitionContext.viewController(forKey: .to) as? TransitionCollectionViewViewController2,
            let toView = vc2.view,
            let cellImageSnapshot = delegate?.snapShotView().snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = vc2.locationImageView.snapshotView(afterScreenUpdates: true),
            let cellImageViewRect =
                delegate?.snapShotView().convert(delegate?.snapShotView().bounds ?? CGRect(), to: window)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        let controllerImageViewRect = vc2.locationImageView.convert(vc2.locationImageView.bounds, to: window)
             
        containerView.addSubview(toView)
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = vc2.view.backgroundColor
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0
        toView.alpha = 0
        containerView.addSubview(backgroundView)
        containerView.addSubview(cellImageSnapshot)
        containerView.addSubview(controllerImageSnapshot)
        cellImageSnapshot.frame = cellImageViewRect
        cellImageSnapshot.alpha = 1
        controllerImageSnapshot.frame = cellImageViewRect
        controllerImageSnapshot.alpha = 0
        performAnimation(duration: Self.duration) {
            cellImageSnapshot.alpha = 0
            cellImageSnapshot.frame =  controllerImageViewRect
            controllerImageSnapshot.alpha = 1
            controllerImageSnapshot.frame =  controllerImageViewRect
            fadeView.alpha = 1
        } completion: { (success) in
            cellImageSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            toView.alpha = 1
            transitionContext.completeTransition(true)
        }
    }
}
enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
