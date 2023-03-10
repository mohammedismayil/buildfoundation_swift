//
//  ShareViewController.swift
//  buildFoundationShareExtension
//
//  Created by ismayil-16441 on 10/02/23.
//

import UIKit
import Social
import Intents

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        // Populate the recipient property with the metadata in case the user taps a suggestion from the share sheet.
                let intent = self.extensionContext?.intent as? INSendMessageIntent
                if intent != nil {
                    let conversationIdentifier = intent!.conversationIdentifier
//                    self.recipient = recipient(identifier: conversationIdentifier!)
                }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
