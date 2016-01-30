//
//  ViewController.swift
//  Pawawaps
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let pawaview = LandscapeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("This is the story all about how", forState: .Normal)
        button.verticalPawawaxEnabled = true
        
        pawaview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.addSubview(pawaview)
        
        view.addConstraint(pawaview.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        view.addConstraint(pawaview.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor))
        view.addConstraint(pawaview.widthAnchor.constraintEqualToConstant(816))
        view.addConstraint(pawaview.heightAnchor.constraintEqualToConstant(480))
        
        view.addConstraint(button.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        view.addConstraint(button.bottomAnchor.constraintEqualToAnchor(pawaview.topAnchor, constant: -100))
    }
}

