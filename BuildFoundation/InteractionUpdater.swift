//
//  InteractionUpdater.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 13/03/23.
//

import Foundation

class InteractionUpdater {
    
    static let shared = InteractionUpdater()
    
    private init(){
        print("InteractionUpdater initiated")
    }
    
    
//    required init(){
//
//    }
//
    static func setUpConfig() {
    
        print("Setting up")
    }
    
    func updateInteraction<T>(interaction:T) {
        print("Interaction \(interaction)")
    }
}
