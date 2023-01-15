//
//  FrameVsBounds.swift
//  SampleTable
//
//  Created by ismayil on 14/01/23.
//

import Foundation

import UIKit


class FrameVsBoundsVC:UIViewController{
    
    
    var childView:UIView! =  {
        
        let view = UIView()
         
        return view
    }()
    
    var parentView:UIView! =  {
        
        let view = UIView()
         
        return view
    }()
    
    
    var grandParentView:UIView! =  {
        
        let view = UIView()
         
        return view
    }()
    
    var rotateButton:UIButton! =  {
        
        let view = UIButton()
         
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    
    
    var rotationDegrees = 0 {
        didSet{
            debugViews()
        }
    }
    
    override func viewDidLoad() {
        print("Welcome to framevsbounds")
        
        setupUI()
    }
    
    
    func debugViews(){
        
//        print(childView.frame)
//
//        print(childView.bounds)
    }
    
    func setupUI(){
        
        debugViews()
        view.backgroundColor = UIColor.gray
        self.view.addSubview(rotateButton)
        self.view.addSubview(childView)
        self.childView.addSubview(parentView)
    
        rotateButton.setTitle("Rotate", for: .normal)
        
        rotateButton.backgroundColor = UIColor.red
        

        let tapAction = UIGestureRecognizer(target: self, action: #selector(self.rotateChild))
        
        rotateButton.addTarget(self, action: #selector(self.rotateChild), for: .touchUpInside)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.isUserInteractionEnabled = true
        
        childView.backgroundColor = UIColor.green
        parentView.backgroundColor = UIColor.yellow
        
        parentView.translatesAutoresizingMaskIntoConstraints = false
        childView.frame = CGRect(x: 180, y: 200, width: 100, height: 100)
        NSLayoutConstraint.activate([parentView.leadingAnchor.constraint(equalTo: childView.leadingAnchor,constant: 10),parentView.trailingAnchor.constraint(equalTo: childView.trailingAnchor,constant: -10),parentView.topAnchor.constraint(equalTo: childView.topAnchor,constant: 10),parentView.bottomAnchor.constraint(equalTo: childView.bottomAnchor,constant: -10)])
        
        
        NSLayoutConstraint.activate([rotateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 300),rotateButton.heightAnchor.constraint(equalToConstant: 50),rotateButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 500),rotateButton.widthAnchor.constraint(equalToConstant: 100)])

    }
    
    
    
    
    
    @objc func rotateChild(){
//         rotationDegrees += 15
//        childView.transform = CGAffineTransform(rotationAngle: CGFloat(rotationDegrees) * .pi / 180)
        
        
        
        childView.frame =  CGRect(x: CGFloat(Int(childView.frame.minX) + 2), y: CGFloat(Int(childView.frame.minY)), width: childView.frame.size.width, height: childView.frame.size.height)
        debugViews()
    }
    
    override func viewDidLayoutSubviews() {
        debugViews()
    }
    
}
