//
//  LayoutConstraintsExtension.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 08/03/23.
//

import Foundation
import UIKit

extension UIView {
    
    func alignCenterTo(_view:UIView){
        
        NSLayoutConstraint.activate([ self.centerXAnchor.constraint(equalTo: _view.centerXAnchor, constant: CGFloat(0)),
                                      self.centerYAnchor.constraint(equalTo: _view.centerYAnchor, constant: CGFloat(0))])
                                      }
                                      }
