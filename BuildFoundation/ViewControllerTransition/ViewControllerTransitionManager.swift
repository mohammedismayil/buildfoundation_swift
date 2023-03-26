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
    static let duration: TimeInterval = 5
    
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
            let vc2 = transitionContext.viewController(forKey: .to) as? TransitionReceiveVC,
            let toView = vc2.view,
            let listView = delegate?.snapShotView(),
            let cellImageSnapshot = delegate?.snapShotView().snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = vc2.avatarView.snapshotView(afterScreenUpdates: true),
            let previewSnapShot = vc2.view.snapshotView(afterScreenUpdates: true),
            let cellImageViewRect =
                delegate?.snapShotView().convert(delegate?.snapShotView().bounds ?? CGRect(), to: window),
            let imageRect =
                delegate?.snapShotView().convert(CGRect(x: 0, y: 0, width: 50, height: 50), to: window)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let roundImageRect = CGRect(x: Int(imageRect.x), y: Int(imageRect.y), width: 50, height: 50)
        let controllerImageViewRect = vc2.avatarView.convert(vc2.avatarView.bounds, to: window)
        let center = vc2.view.center
        containerView.addSubview(toView)
        toView.alpha = 0
        containerView.addSubview(previewSnapShot)
        containerView.addSubview(cellImageSnapshot)
        previewSnapShot.frame = cellImageViewRect
        previewSnapShot.alpha = 1
        cellImageSnapshot.frame = roundImageRect
        cellImageSnapshot.alpha = 1
        performAnimation(duration: 0.428*Self.duration) {
            previewSnapShot.alpha = 0
        } completion: { _ in
            
        }
        performAnimation(duration: Self.duration) {
            cellImageSnapshot.alpha = 1
            cellImageSnapshot.frame =  controllerImageViewRect
            previewSnapShot.frame =  controllerImageViewRect
            previewSnapShot.alpha = 0
            toView.center = center
        } completion: { (success) in
            cellImageSnapshot.removeFromSuperview()
            previewSnapShot.removeFromSuperview()
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
            let toView = vc2.getImage(),
            let listView = delegate?.snapShotView(),
            let cellImageSnapshot = delegate?.snapShotView().snapshotView(afterScreenUpdates: false),
            let controllerImageSnapshot = toView.snapshotView(afterScreenUpdates: false),
            let cellImageViewRect =
                delegate?.snapShotView().convert(delegate?.snapShotView().bounds ?? CGRect(), to: window)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        let controllerImageViewRect = toView.convert(toView.bounds, to: window)
        let center = toView.center
        containerView.addSubview(toView)
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = vc2.view.backgroundColor
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0
        toView.alpha = 0
//        containerView.addSubview(backgroundView)
//        containerView.addSubview(cellImageSnapshot)
//        containerView.addSubview(controllerImageSnapshot)
        let circleView = UIView()
        circleView.backgroundColor = .black
        circleView.frame = toView.frameToFitWidth(frame: listView.frame)
        circleView.layer.cornerRadius = listView.layer.cornerRadius ?? circleView.frame.width/2
        toView.addSubview(circleView)
        toView.mask = circleView
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
            circleView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            toView.transform = .identity
            toView.center = center
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
