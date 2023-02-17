//
//  UILayoutPriorityVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/02/23.
//

import Foundation
import UIKit

class UILayoutPriorityVC : UIViewController{
    
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var addBtnLeadingConstraint:NSLayoutConstraint!
    var addBtnTrailingConstraint:NSLayoutConstraint!
    var addBtnWidthConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(addBtn)
        setupUI()
    }
    
    func setupUI(){
        
        addBtnLeadingConstraint = addBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        addBtnLeadingConstraint.isActive = true
        addBtnLeadingConstraint.priority = UILayoutPriority.required
        
        
        addBtnWidthConstraint = addBtn.widthAnchor.constraint(equalToConstant: 100)
        addBtnWidthConstraint.isActive = true
        addBtnWidthConstraint.priority = UILayoutPriority.required
        
        addBtnTrailingConstraint = addBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        addBtnTrailingConstraint.isActive = true
        addBtnTrailingConstraint.priority = UILayoutPriority.required
        
//        addBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            addBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),addBtn.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
}
