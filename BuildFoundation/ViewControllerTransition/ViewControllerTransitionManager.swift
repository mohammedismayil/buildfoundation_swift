//
//  ViewControllerTransitionManager.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import Foundation
import UIKit

final class ViewControllerTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 9
    
    static let duration: TimeInterval = 3
    
    private let type: PresentationType
    private let firstViewController: TransitionCollectionViewViewController
    private let secondViewController: TransitionCollectionViewViewController2
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(type: PresentationType, firstViewController: TransitionCollectionViewViewController, secondViewController: TransitionCollectionViewViewController2, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ,
              let selectedCell = firstViewController.selectedCell
        else { return nil }
        
        // 11
        self.cellImageViewRect = selectedCell.locationImageView.convert(selectedCell.locationImageView.bounds, to: window)
        
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
        guard let toView = secondViewController.view
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        containerView.addSubview(toView)
        
        guard
            let selectedCell = firstViewController.selectedCell,
            let window = firstViewController.view.window ?? secondViewController.view.window,
            let cellImageSnapshot = selectedCell.locationImageView.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = secondViewController.locationImageView.snapshotView(afterScreenUpdates: true)
                
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor
        selectedCellImageViewSnapshot = cellImageSnapshot
        backgroundView = UIView(frame: containerView.bounds)
        backgroundView.addSubview(fadeView)
        fadeView.alpha = 0
        toView.alpha = 0
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }
        let controllerImageViewRect = secondViewController.locationImageView.convert(secondViewController.locationImageView.bounds, to: window)
        
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = cellImageViewRect
            $0.layer.cornerRadius =  12
            $0.layer.masksToBounds = true
        }
        controllerImageSnapshot.alpha = 0
        selectedCellImageViewSnapshot.alpha = 1
        
        
        performAnimation(duration: Self.duration) {
            
            self.selectedCellImageViewSnapshot.alpha = 0
            controllerImageSnapshot.alpha = 1
            // 38
            self.selectedCellImageViewSnapshot.frame =  controllerImageViewRect
            controllerImageSnapshot.frame =  controllerImageViewRect
            fadeView.alpha = 1
            [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                $0.layer.cornerRadius = 0
            }
        } completion: { (success) in
            // 29
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
