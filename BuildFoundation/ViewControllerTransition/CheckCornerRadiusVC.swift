//
//  CheckCornerRadiusVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 30/03/23.
//

import UIKit

class CheckCornerRadiusVC: UIViewController {

    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        view1.layer.cornerRadius = 50
        view1.layer.borderWidth = 10
        view1.layer.borderColor = UIColor.red.cgColor
        
        
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
