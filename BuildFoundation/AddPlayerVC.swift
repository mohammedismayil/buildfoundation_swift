//
//  AddPlayerVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 15/01/23.
//

import Foundation
import UIKit


class AddPlayerVC:UIViewController{
    
    
    var addBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI(){
        
        self.view.addSubview(addBtn)
        
        addBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        
        addBtn.backgroundColor = UIColor.gray
    }
}
