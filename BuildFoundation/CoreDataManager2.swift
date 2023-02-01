//
//  CoreDataManager2.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 01/02/23.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager2{
    
    static let shared = CoreDataManager2()
    
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
    
    
    func addDummyPlayerData(){
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
