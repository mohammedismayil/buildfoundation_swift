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
    
    var removeBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
        btn.setTitle("Remove", for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var player: FootballPlayer!
    

    
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
        self.view.addSubview(removeBtn)
        self.addBtn.frame = CGRect(x:( UIScreen.main.bounds.width / 2) - 110, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        addBtn.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        self.removeBtn.frame = CGRect(x:addBtn.frame.maxX + 20, y: addBtn.frame.minY, width: 100, height: 40)
        removeBtn.addTarget(self, action: #selector(removeButtonAction), for: .touchUpInside)
//        NSLayoutConstraint.activate([
//
//            nameTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            nameTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//            nameTextView.heightAnchor.constraint(equalToConstant: 40),
//            nameTextView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
//
//        ])
        player = FootballPlayer()
        self.player.addObserver(self, forKeyPath: "playerName", options: [.new,.old],context: nil)
    }
    
    @objc func addButtonAction(){
       
        player.playerName = "Messi"
        
        print("Add Tapped")
    }
    
    @objc func removeButtonAction(){
       
    }
    
    
    
    func donateIntent(){
        
        let groupName = INSpeakableString(spokenPhrase: "manimaran")
        
        
          if #available(iOS 14.0, *) {
              let sendMessageIntent = INSendMessageIntent.init(recipients: nil,
                                                               outgoingMessageType: .outgoingMessageText,
                                                               content: "sharetesting",
                                                               speakableGroupName: groupName,
                                                               conversationIdentifier: "com.ismayil.share1",
                                                               serviceName: nil, sender: nil, attachments: nil)
              let image = INImage(named: "Image1")
              sendMessageIntent.setImage(image, forParameterNamed: \.speakableGroupName)

              IntentHandler.donateInteractionUsing(intent: sendMessageIntent, isOutgoing: true)
          } else {
              // Fallback on earlier versions
          }
        
    }
    
    func removeAllIntents(){
        INInteraction.deleteAll()
    }
    
    
//    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print("Observed \(keyPath) \(object ?? "")")
//    }
//    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        print("Observed \(keyPath) \(object ?? "")")
        if keyPath == "text" {
            print("do something when the textField's text your observing changes")
        }
    }
    
}

struct IntentHandler {
  static func donateInteractionUsing(intent: INSendMessageIntent, isOutgoing: Bool) {
    
    // Donate the intent.
    let interaction = INInteraction(intent: intent, response: nil)
    interaction.direction = isOutgoing ? .outgoing : .incoming
    interaction.groupIdentifier = "1677899"
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
  }
}

extension UIViewController{
    
    
    func showToast(){
        
    }
}
