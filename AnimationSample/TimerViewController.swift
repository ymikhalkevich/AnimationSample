//
//  TimerViewController.swift
//  AnimationSample
//
//  Created by Yury Mikhalkevich on 8/16/18.
//  Copyright © 2018 Слава. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    private let swipRightGuestureRecognizer: UISwipeGestureRecognizer = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        swipRightGuestureRecognizer.addTarget(self, action: #selector(swipGuestureAction))
        swipRightGuestureRecognizer.direction = .right
        

        // Do any additional setup after loading the view.
    }

    @objc
    func swipGuestureAction (sender: UISwipeGestureRecognizer) {
     //   print("right swipe")
        
        UIView.animate(withDuration: 10.0,
                       delay: 10.0, options: .curveEaseInOut,
                       animations: {
                         self.sliderAnimatedConstraints.constant = 0
        },
                       completion: nil)
        
        
    }

    @IBOutlet weak var sliderToPause: UILabel! {
        didSet {
            oldValue?.removeGestureRecognizer(swipRightGuestureRecognizer)
            sliderToPause?.addGestureRecognizer(swipRightGuestureRecognizer)
        }
    }
    
    @IBAction func resumeBtnAction(_ sender: UIButton) {
        UIView.animate(withDuration: 10.0,
                       delay: 10.0, options: .curveEaseInOut,
                       animations: {
                        self.sliderAnimatedConstraints.constant = -375
        },
                       completion: nil)
    }
    
    @IBOutlet weak var sliderAnimatedConstraints: NSLayoutConstraint!
    @IBOutlet weak var stackHorizontal: UIStackView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
