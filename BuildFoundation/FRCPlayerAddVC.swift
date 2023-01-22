//
//  FRCPlayerAddVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 18/01/23.
//

import Foundation
import UIKit
import CoreData

class FRCPlayerAddVC: UIViewController{
    
    var coreDataHandler:CoreDataManager!
   
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        
        coreDataHandler = CoreDataManager.shared
        
        self.view.addSubview(addBtn)
        self.addBtn.frame = CGRect(x: (UIScreen.main.bounds.width / 2) - 50 , y:( self.view.frame.height / 2 ) - 20 , width: 100, height: 40)
        addBtn.addTarget(self, action: #selector(addDummyRecord), for: .touchUpInside)
        
    }
    
    @objc func addDummyRecord(){
        coreDataHandler.addDummyPlayerData()
    }
}
