//
//  MatchEntity.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 21/03/23.
//

import Foundation
import CoreData


extension MatchEntity{
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<MatchEntity> {
        return NSFetchRequest<MatchEntity>(entityName: "MatchEntity")
    }
     
}
