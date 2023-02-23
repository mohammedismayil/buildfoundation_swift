//
//  CASpringAnimationTestVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 23/02/23.
//

import Foundation
import UIKit

class CASpringAnimationTestVC: UIViewController {
    
    private let ball1View: UIView = {
        let view = UIView()
        return view
    }()
    
    var animateBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
        btn.translatesAutoresizingMaskIntoConstraints = true
        btn.setTitle("Animate", for: .normal)
        return btn
    }()
    
    var slider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    var currentAnimation = 1
    
    override func viewDidLoad() {
        
        setupUI()
        animateBtn.addTarget(self, action: #selector(animateAction), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(ball1View)
//        self.view.addSubview(animateBtn)
        self.view.addSubview(slider)
        
        

        self.ball1View.frame = CGRect(x: self.view.center.x - 10, y: self.view.center.y  , width: 20, height: 20)
        self.animateBtn.frame = CGRect(x: self.view.center.x - 75, y: self.view.center.y + 100  , width: 100, height: 50)
        
        self.slider.frame = CGRect(x: 20, y: self.view.frame.height - 100, width: self.view.frame.width - 40, height: 50)
        self.ball1View.layer.cornerRadius = ball1View.frame.height / 2
        
        self.ball1View.backgroundColor = UIColor.green
    }
    
    @objc func animateAction() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 1
        pulse.toValue = 1.5
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.1
        pulse.damping = 10
        
//        ball1View.layer.add(pulse, forKey: "pulse")
        
       

        for i in 1..<10 {
//            ball1View.transform = CGAffineTransform(scaleX:0.2 * CGFloat(i), y: 0.2 * CGFloat(i))
        }
        
        
        UIView.animate(withDuration: 1, delay: 0) {

//            switch self.currentAnimation {
//            case 0 :
//                self.ball1View.transform = CGAffineTransform(scaleX: 2, y: 2)
//
//            case 1 :
//                self.ball1View.layer.add(pulse, forKey: "pulse")
//                self.ball1View.transform = .identity
//            default:
//                break
//            }
            
            self.ball1View.transform = CGAffineTransform(scaleX: CGFloat(1 * self.currentAnimation), y: CGFloat(1 * self.currentAnimation))

        }
        
        currentAnimation += 1
        
    }
    
    @objc func sliderValueChanged() {
        
        print(slider.value  )
        
        UIView.animate(withDuration: 1, delay: 0) {
            if self.slider.value == 1 {
                self.ball1View.transform = .identity
                let pulse = CASpringAnimation(keyPath: "transform.scale")
                pulse.duration = 1
                pulse.fromValue = 1
                pulse.toValue = 1.5
                pulse.autoreverses = false
                pulse.repeatCount = 1
                pulse.initialVelocity = 0.1
                pulse.damping = 1
                self.ball1View.layer.add(pulse, forKey: "pulse")
            }else{
                self.ball1View.transform = CGAffineTransform(scaleX: CGFloat(self.slider.value * 2) , y: CGFloat(self.slider.value * 2))
            }
           

        }
    }
}
