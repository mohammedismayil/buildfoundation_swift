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
    
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        
        
        
        self.view.addSubview(addBtn)
        self.addBtn.frame = CGRect(x: (UIScreen.main.bounds.width / 2) - 50 , y:( self.view.frame.height / 2 ) - 20 , width: 100, height: 40)
        addBtn.addTarget(self, action: #selector(addDummyRecord), for: .touchUpInside)
        
    }
    
    @objc func addDummyRecord(){
        
        
        
            
        
        
        let managedContext = appDel.persistentContainer.viewContext
        let entity = PlayerEntity(entity:NSEntityDescription.entity(forEntityName: "PlayerEntity", in : managedContext)! , insertInto: managedContext)
        
        entity.name = "Peter"

                //4
        do {
            try managedContext.save()
            
            
            
        }catch {
            
        }
        
        
    }
}
