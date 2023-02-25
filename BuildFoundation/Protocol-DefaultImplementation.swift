//
//  Protocol-DefaultImplementation.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 30/01/23.
//

import Foundation

class ARandomSubscriber: Subscriber{
    
}
protocol Subscriber{
    var name:String!{get set}
}

extension Subscriber{
    var name:String!{get{return nil} set{}}
}
