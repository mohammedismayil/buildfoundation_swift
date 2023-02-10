//
//  BlankHomeVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 31/01/23.
//

import Foundation
import UIKit
import Intents


class BlankHomeVC:UIViewController{
    
    
    
    private var nameTextView : UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
//        self.view.addSubview(nameTextView)
        
//        nameTextView.backgroundColor = .darkGray
//
//        nameTextView.typingAttributes = [NSAttributedString.Key : .font]
//        nameTextView.textColor = .green
        
        self.view.addSubview(addBtn)
        self.addBtn.frame = CGRect(x:( UIScreen.main.bounds.width / 2) - 50, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        addBtn.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
//        NSLayoutConstraint.activate([
//
//            nameTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            nameTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//            nameTextView.heightAnchor.constraint(equalToConstant: 40),
//            nameTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
//
//        ])
    }
    
    @objc func addButtonAction(){
        
        donateIntent()
    }
    
    
    func donateIntent(){
        let groupName = INSpeakableString(spokenPhrase: "Vineeth")
        
        
        if #available(iOS 14.0, *) {
            // Add the user's avatar to the intent.
            let image = INImage(named: "user")
            let sendMessageIntent = INSendMessageIntent.init(recipients: [INPerson(personHandle: INPersonHandle(value: "1", type: .unknown), nameComponents: nil, displayName: "Vineeth", image: image, contactIdentifier: "1", customIdentifier: "chat")],
                                                             outgoingMessageType: .outgoingMessageText,
                                                             content: "Testing",
                                                             speakableGroupName: groupName,
                                                             conversationIdentifier: "com.fhetch.message",
                                                             serviceName: nil, sender: nil, attachments: nil)
           
            sendMessageIntent.setImage(image, forParameterNamed: \.speakableGroupName)
            
            
            
            // Donate the intent.
            let interaction = INInteraction(intent: sendMessageIntent, response: nil)
            interaction.direction = .incoming
            interaction.groupIdentifier = "TestIdentifier123"
            interaction.donate(completion: { error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Interaction donate Failure with error: \(error as Any)")
                    } else {
                        // Do something, e.g. send the content to a contact.
                        print("Successfully donated interaction")
                    }
                }
            })
            
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    func incomingMessageIntent(){
        
    }
        
    
}
