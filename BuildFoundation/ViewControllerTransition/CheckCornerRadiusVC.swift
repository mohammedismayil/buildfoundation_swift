//
//  CheckCornerRadiusVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 30/03/23.
//

import UIKit

class CheckCornerRadiusVC: UIViewController {

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        view1.layer.cornerRadius = 50
        view1.layer.cornerRadius = 25
        view1.layer.borderColor = UIColor.red.cgColor
        
        view2.layer.cornerRadius = 25
        view1.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        let duration:TimeInterval = 0.4
        
        UIView.animate(withDuration: duration, delay: duration) {
            
            self.view1.transform = CGAffineTransform(translationX: self.view2.frame.x - 40 , y: -20)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
