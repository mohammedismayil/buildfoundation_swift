//
//  TransitionReceiveVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 23/03/23.
//
import UIKit
import Foundation

class TransitionReceiveVC: UIViewController {
    
    var data: TransitionCellData!
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
   
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBAction func close(_ sender: Any) {
       
        
        
    }
    @IBAction func nextAction(_ sender: Any) {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransitionReceiveVC2") as! TransitionReceiveVC2

        // 4
        secondViewController.transitioningDelegate = self

        secondViewController.modalPresentationStyle = .fullScreen
//        secondViewController.data = data
        present(secondViewController, animated: true)
        
    }
    override func viewDidLoad() {
        print("loaded")
        
        self.view.backgroundColor = .white
        avatarView.frame = CGRect(x: 20, y: 100, width: 25, height: 25)
        
        nameLabel.frame = CGRect(x: 50, y: 100, width: 100, height: 20)
        closeButton.frame = CGRect(x: self.view.frame.width - 80, y: 100, width: 50, height: 30)
        placeImageView.frame = CGRect(x: 50 , y: 500, width: 50, height: 50)
        placeImageView.layer.cornerRadius = 25
        placeImageView.image = SampleTransitionImages.data[0].image
        avatarView.image = SampleTransitionImages.data[0].image
        let cross = #imageLiteral(resourceName: "cross").withRenderingMode(.alwaysTemplate)
        closeButton.setImage(cross, for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = .black
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        
        avatarView.layer.masksToBounds = true
//        avatarView.layoutIfNeeded()
    }
}

extension TransitionReceiveVC: UIViewControllerTransitioningDelegate{
    

func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    let animator = TransitionReceiveVC2Animator(type: .present)
    return animator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = TransitionReceiveVC2Animator(type: .dismiss)
        return animator

    }
}

