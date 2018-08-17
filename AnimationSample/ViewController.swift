//
//  ViewController.swift
//  AnimationSample
//
//  Created by Слава on 14.08.2018.
//  Copyright © 2018 Слава. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // we can animate from the box:
    // 1. CGRect(width, height)
    // 2. Constrints
    // 3. backgroundcolor(of the view)
    // 4. alpha(opeque to transparent) 0.0  to 1.0
    // 5. transition
    
    @IBOutlet weak var viewToAnimate: UIView!
    @IBOutlet weak var backgroundToAnimate: UIImageView!
    @IBOutlet weak var logoToAnimate: UIButton!
    
    @IBOutlet weak var textFieldWithShake: ShakableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldWithShake.delegate = self
        
        // complition выполняется после завершения анимации
        
        //Animating the view
        //        UIView.animate(withDuration: 3.0,
        //                       animations: {
        //
        //            self.viewToAnimate.backgroundColor = .red
        //            self.viewToAnimate.frame.size.width *= 2.0
        //            self.viewToAnimate.frame.size.height *= 2.0
        //
        //        },
        //                       completion: nil)
        
        // Using spring withDamping
        // options - как будет двигаться анимация
        // Почему от UIView - потому что static metod
        
        //        UIView.animate(withDuration: 3.0, delay: 2.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 2.0, options: .curveLinear, animations: {
        //            self.viewToAnimate.backgroundColor = .red
        //            self.viewToAnimate.frame.size.width *= 2.0
        //            self.viewToAnimate.frame.size.height *= 2.0
        //        }, completion: nil)
        
        
        //        UIView.animate(withDuration: 5.0, delay: 0.0, options: .curveEaseInOut, animations: {
        //            self.viewToAnimate.backgroundColor = .brown
        //        }, completion: { (complition) in
        //            print("Animation was finished")
        //            })
        parallax(toView: backgroundToAnimate, magnitude: 20)
        parallax(toView: logoToAnimate, magnitude: -20)
    }
    
    private func parallax(toView view: UIView, magnitude: Float) {
        
        let xMotion = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: .tiltAlongHorizontalAxis)
        
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: .tiltAlongVerticalAxis)
        
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
 
    @IBAction func goToTimerBtnAction(_ sender: UIButton) {
  
    }
    
    @IBAction func animateBounds(_ sender: UIButton) {
        
        let bounds = sender.bounds
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6,
                       options: .allowUserInteraction,
                       animations: {
                        sender.bounds = CGRect(x: bounds.origin.x,
                                               y: bounds.origin.y,
                                               width: bounds.size.width + 100,
                                               height: bounds.size.height + 100)
        }) { (success) in
            if success {
                UIView.animate(withDuration: 0.5, animations: {
                    sender.bounds = bounds
                })
            }
        }
    }
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textFieldWithShake.text != "123" {
            textFieldWithShake.shake()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldWithShake.resignFirstResponder()
        return true
    }
}

