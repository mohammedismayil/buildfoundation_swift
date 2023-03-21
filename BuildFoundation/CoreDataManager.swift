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
    
    var matchFetchController:NSFetchedResultsController<MatchEntity>! = nil
    
    
    
    
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
    
    func fetchMatchesData(){
       
       
       let request = MatchEntity.createFetchRequest()
      
               let sort = NSSortDescriptor(key: "location", ascending: false)
              request.sortDescriptors = [sort]

        matchFetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDel.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
       
       
       
       
       do {
           try   matchFetchController.performFetch()
           
       }catch{
           
           
       }
   }
   
    func addDummyPlayerData(){
        let managedContext = appDel.persistentContainer.viewContext
        let entity = PlayerEntity(entity:NSEntityDescription.entity(forEntityName: "PlayerEntity", in : managedContext)! , insertInto: managedContext)
        
        entity.name = "Peter"
        entity.playerID = Int64(UUID().hashValue)

                //4
        do {
            try managedContext.save()
            
            
            
        }catch {
            
        }
    }
    func addDummyMatchesData(){
        let managedContext = appDel.persistentContainer.viewContext
        let entity = MatchEntity(entity:NSEntityDescription.entity(forEntityName: "MatchEntity", in : managedContext)! , insertInto: managedContext)
        
        entity.location = "Brisbane"
        entity.matchID = Int64(UUID().hashValue)

                //4
        do {
            try managedContext.save()
            
            
            
        }catch {
            
        }
    }
}
