//
//  CheckCrashReportVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 15/03/23.
//

import Foundation
import UIKit
import SimpleCustomUIComponentsSwift

class CheckCrashReportVC: UIViewController {
   
    private let crashButton: CustomAddButton = {
        let button = CustomAddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Crash", for: .normal)
        return button
        
    }()
    
    @IBOutlet weak var userNameLabel:UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden =  true
        self.view.backgroundColor = .white
        self.view.addSubview(crashButton)
        
        
        
        crashButton.setHeightAndWidth(height: 50, width: 150)
        crashButton.alignCenterTo(_view: self.view)
        
        crashButton.addTarget(self, action: #selector(crashAction), for: .touchUpInside)
    }
    
    @objc func crashAction() {
        userNameLabel.text = "helo"
    }
    
    
}
