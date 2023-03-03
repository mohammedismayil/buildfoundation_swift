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
//        NSLayoutConstraint.activate([ addBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: CGFloat(0)),
//                                      addBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: CGFloat(0)),
//                                      addBtn.widthAnchor.constraint(equalToConstant: 100),
//                                      addBtn.heightAnchor.constraint(equalToConstant: 50)])
        
    }
}
