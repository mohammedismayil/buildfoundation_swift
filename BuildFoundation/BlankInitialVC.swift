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
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
        
    }()
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden =  true
        self.view.backgroundColor = .white
        
        self.view.addSubview(addBtn)
        addBtn.alignCenterTo(_view: self.view)
        addBtn.setHeightAndWidth(height: 50, width: 100)
        
    }
}
