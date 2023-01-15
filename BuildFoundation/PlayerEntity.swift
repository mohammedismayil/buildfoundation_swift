//
//  PlayerEntity.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 15/01/23.
//

import Foundation
import CoreData


extension PlayerEntity{
    
    
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
//          return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
//      }

//      @NSManaged public var name: String?
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }
     
}
