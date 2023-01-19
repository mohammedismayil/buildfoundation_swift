//
//  ThemeAddButton.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 18/01/23.
//

import Foundation

import UIKit


class ThemeAddButton:UIButton{
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.purple
        
        self.isUserInteractionEnabled = true
      
        self.setTitleColor(.white, for: .normal)
        self.setTitle("Add", for: .normal)

    }
    
    
    func updateUI(){
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {

//        self.layer.cornerRadius = self.frame.height / 2
//    }
}
