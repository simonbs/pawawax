//
//  ViewController.swift
//  Pawawaps
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("This is the story all about how", forState: .Normal)
        button.verticalPawawaxEnabled = true
        
        let landscapeView1 = LandscapeView()
        let landscapeView2 = LandscapeView()
        
        landscapeView1.translatesAutoresizingMaskIntoConstraints = false
        landscapeView2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.addSubview(landscapeView1)
        view.addSubview(landscapeView2)
        
        view.addConstraint(landscapeView1.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(landscapeView1.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor))
        view.addConstraint(landscapeView1.widthAnchor.constraintEqualToConstant(816))
        view.addConstraint(landscapeView1.heightAnchor.constraintEqualToConstant(480))
        
        view.addConstraint(landscapeView2.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -90))
        view.addConstraint(landscapeView2.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor))
        view.addConstraint(landscapeView2.widthAnchor.constraintEqualToConstant(816))
        view.addConstraint(landscapeView2.heightAnchor.constraintEqualToConstant(480))
        
        view.addConstraint(button.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(button.bottomAnchor.constraintEqualToAnchor(landscapeView1.topAnchor, constant: -100))
    }
}

