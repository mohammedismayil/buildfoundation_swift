//
//  BlankHomeVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 31/01/23.
//

import Foundation
import UIKit


class BlankHomeVC:UIViewController{
    
    
    
    private var nameTextView : UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(nameTextView)
        
//        nameTextView.backgroundColor = .darkGray
//
//        nameTextView.typingAttributes = [NSAttributedString.Key : .font]
//        nameTextView.textColor = .green
        
        
        
        NSLayoutConstraint.activate([
        
            nameTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            nameTextView.heightAnchor.constraint(equalToConstant: 40),
            nameTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        
        ])
    }
}
