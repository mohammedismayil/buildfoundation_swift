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
   
   
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        print("loaded")
        
        
        avatarView.frame = CGRect(x: 20, y: 100, width: 25, height: 25)
        
        nameLabel.frame = CGRect(x: 50, y: 100, width: 100, height: 20)
        closeButton.frame = CGRect(x: self.view.frame.width - 80, y: 100, width: 50, height: 30)
        avatarView.image = data.image
        let cross = #imageLiteral(resourceName: "cross").withRenderingMode(.alwaysTemplate)
        closeButton.setImage(cross, for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = .black
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        
        avatarView.layer.masksToBounds = true
//        avatarView.layoutIfNeeded()
    }
}
