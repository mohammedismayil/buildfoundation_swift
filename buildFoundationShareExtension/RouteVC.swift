//
//  RouteVC.swift
//  buildFoundationShareExtension
//
//  Created by ismayil-16441 on 11/02/23.
//

import Foundation
import UIKit
import Intents

class RouteVC:UIViewController{
    
    
  
    override func viewDidLoad() {
        
        
        if let intent = self.extensionContext?.intent as? INSendMessageIntent{
            print(intent)
            
            if intent.conversationIdentifier == "newchat"{
               
                moveToNewChat()
            }
        }
    }
    
    func moveToNewChat(){
        
        let storyBoard = UIStoryboard(name: "MainInterface", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreateChatVC") as! CreateChatVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
