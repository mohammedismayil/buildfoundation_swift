//
//  LayoutConstraintsExtension.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 08/03/23.
//

import Foundation
import UIKit

extension UIView {
    
    var viewCenter: CGPoint {
        return CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
    }
    
    func alignCenterTo(_view:UIView){
        
        NSLayoutConstraint.activate([ self.centerXAnchor.constraint(equalTo: _view.centerXAnchor, constant: CGFloat(0)),
                                      self.centerYAnchor.constraint(equalTo: _view.centerYAnchor, constant: CGFloat(0))])
    }
    
    func setHeightAndWidth(height:CGFloat,width:CGFloat) {
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalToConstant: width),
                                     self.heightAnchor.constraint(equalToConstant: height)])
    }
    
    func frameToFitWidth(frame: CGRect) -> CGRect {
        let scale = self.bounds.width/frame.width
        var frame = CGRect(x: 0, y: 0, width: frame.width*scale, height: frame.height*scale)
        frame.center = viewCenter
        return frame
    }
}

extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
}
