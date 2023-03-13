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
    
    static func setUpConfig() {
    
        print("Setting up")
    }
    
    func updateInteraction<T>(interaction:T) {
        DispatchQueue.main.async {
            print("Interaction Main thread\(interaction)")
        }
        DispatchQueue.global().async {
            print("Interaction Global thread\(interaction)")
        }
    }
}
