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

    static let duration: TimeInterval = 10

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

        // 21
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

        // 33
//        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot

            // 41
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
//        } else {
//            backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
//            backgroundView.addSubview(fadeView)
//        }

        // 23
        toView.alpha = 0

        // 34
        // 42
        // 48
        // 54
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }

        // 25
        let controllerImageViewRect = secondViewController.locationImageView.convert(secondViewController.locationImageView.bounds, to: window)
        // 49
        let controllerLabelRect = secondViewController.locationLabel.convert(secondViewController.locationLabel.bounds, to: window)
        // 55
       

        // 35
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = cellImageViewRect

            // 59
            $0.layer.cornerRadius =  12
            $0.layer.masksToBounds = true
        }

        // 36
        controllerImageSnapshot.alpha = 0

        // 37
        selectedCellImageViewSnapshot.alpha = 1

        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // 38
                self.selectedCellImageViewSnapshot.frame =  controllerImageViewRect
                controllerImageSnapshot.frame =  controllerImageViewRect

                // 43
                fadeView.alpha = 1


                // 60
                [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = 0
                }
            }

            // 39
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = 0
                controllerImageSnapshot.alpha = 1
            }

            
        }, completion: { _ in
            // 29
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()

            // 44
            backgroundView.removeFromSuperview()
           
            // 30
            toView.alpha = 1

            // 31
            transitionContext.completeTransition(true)
        })
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
