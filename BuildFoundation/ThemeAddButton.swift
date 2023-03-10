//
//  ThemeAddButton.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 18/01/23.
//

import Foundation

import UIKit


class ThemeAddButton:UIButton{
    
    
    var cornerRadius = 10
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
       
        self.backgroundColor = UIColor.purple
          self.setTitleColor(.white, for: .normal)
          self.setTitle("Add", for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.layer.cornerRadius = CGFloat(cornerRadius)

    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        self.backgroundColor = UIColor.purple
//
//        self.isUserInteractionEnabled = true
//
//        self.setTitleColor(.white, for: .normal)
//        self.setTitle("Add", for: .normal)
//        self.layer.cornerRadius = self.frame.height / 2
//        self.clipsToBounds = true
//    }
}
