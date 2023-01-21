//
//  CoreDataManager.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 21/01/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    var playerFetchController:NSFetchedResultsController<PlayerEntity>! = nil
    
    
    
    
    init(){
        
    }
    
     func fetchPlayersData(){
        
        
        let request = PlayerEntity.createFetchRequest()
       
                let sort = NSSortDescriptor(key: "name", ascending: false)
               request.sortDescriptors = [sort]

        playerFetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDel.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        
        
        
        do {
            try   playerFetchController.performFetch()
            
        }catch{
            
            
        }
    }
}
