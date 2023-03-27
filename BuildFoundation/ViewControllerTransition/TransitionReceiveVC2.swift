//
//  TransitionReceiveVC2.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 25/03/23.
//

import Foundation
import UIKit


class TransitionReceiveVC2: UIViewController {
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        avatarImage.image = SampleTransitionImages.data[0].image
        avatarImage.layer.cornerRadius = 10
    }
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
