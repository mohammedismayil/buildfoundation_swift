//
//  BlankInitialVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 02/03/23.
//

import Foundation
import UIKit
import SimpleCustomUIComponentsSwift
class BlankInitialVC: UIViewController {
    
    
    var addBtn: CustomAddButton = {
    
        let btn = CustomAddButton()
        return btn
        
    }()
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden =  true
        self.view.backgroundColor = .white
        
        self.view.addSubview(addBtn)
        self.addBtn.frame = CGRect(x: 30, y: 50, width: 100, height: 50)
    }
}
