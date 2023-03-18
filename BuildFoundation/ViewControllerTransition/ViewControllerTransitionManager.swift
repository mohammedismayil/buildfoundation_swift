//
//  ViewControllerTransitionManager.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import Foundation
import UIKit

protocol TransitionManagerDelegate: AnyObject {
    func requiredVC()->(cellImageView:UIView,imageRect:CGRect)
}
class ViewControllerTransitionManager: NSObject,UIViewControllerTransitioningDelegate{

    var animator: ViewControllerTransition?
    var delegate: TransitionManagerDelegate?
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        animator = ViewControllerTransition(type: .present, delegate: delegate)
            return animator
        }

        // 3
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
 
            return nil
        }
    
}
final class ViewControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 9
    
    static let duration: TimeInterval = 4
    
    private let type: PresentationType
    var delegate: TransitionManagerDelegate?
    var selectedCellImageViewSnapshot = UIView()
    
    init?(type: PresentationType,delegate:TransitionManagerDelegate?) {
        self.type = type
        self.delegate = delegate
    }
    
    // 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    // 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 18
        let containerView = transitionContext.containerView
        
        // 19
        guard let vc2 = transitionContext.viewController(forKey: .to) as? TransitionCollectionViewViewController2,let toView = vc2.view
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        containerView.addSubview(toView)
        
        guard
            let vc = transitionContext.viewController(forKey: .from) as? TransitionCollectionViewViewController, let selectedCell =  vc.selectedCell,
            let window = vc.view.window,
            let cellImageSnapshot = selectedCell.locationImageView.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = vc2.locationImageView.snapshotView(afterScreenUpdates: true)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = vc2.view.backgroundColor
       
        selectedCellImageViewSnapshot = cellImageSnapshot
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0
        toView.alpha = 0
        containerView.addSubview(backgroundView)
        containerView.addSubview(selectedCellImageViewSnapshot)
        containerView.addSubview(controllerImageSnapshot)
       
        let controllerImageViewRect = vc2.locationImageView.convert(vc2.locationImageView.bounds, to: window)
        
        let cellImageViewRect =
        selectedCell.locationImageView.convert(selectedCell.locationImageView.bounds, to: window)
        vc2.locationImageView.convert(vc2.locationImageView.bounds, to: window)
        
        selectedCellImageViewSnapshot.frame = cellImageViewRect
        controllerImageSnapshot.frame = cellImageViewRect
        controllerImageSnapshot.alpha = 0
        selectedCellImageViewSnapshot.alpha = 1
        performAnimation(duration: Self.duration) {
            self.selectedCellImageViewSnapshot.alpha = 0
            controllerImageSnapshot.alpha = 1
            self.selectedCellImageViewSnapshot.frame =  controllerImageViewRect
            controllerImageSnapshot.frame =  controllerImageViewRect
            fadeView.alpha = 1
        } completion: { (success) in
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            toView.alpha = 1
            transitionContext.completeTransition(true)
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
    
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning?) {
        
    }
}
enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
