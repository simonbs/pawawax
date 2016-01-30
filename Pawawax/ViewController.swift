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
        
        let verticalButton = UIButton(type: .System)
        let horizontalButton1 = UIButton(type: .System)
        let horizontalButton2 = UIButton(type: .System)
        
        verticalButton.translatesAutoresizingMaskIntoConstraints = false
        horizontalButton1.translatesAutoresizingMaskIntoConstraints = false
        horizontalButton2.translatesAutoresizingMaskIntoConstraints = false
        
        verticalButton.verticalPawawaxEnabled = true
        horizontalButton1.horizontalPawawaxEnabled = true
        horizontalButton2.horizontalPawawaxEnabled = true
        horizontalButton2.verticalPawawaxEnabled = true
        
        verticalButton.setTitle("This is the story all about how", forState: .Normal)
        horizontalButton1.setTitle("My life got flipped-turned upside down", forState: .Normal)
        horizontalButton2.setTitle("And I'd like to take a minute", forState: .Normal)
        
        let landscapeView1 = LandscapeView()
        let landscapeView2 = LandscapeView()
        
        landscapeView1.translatesAutoresizingMaskIntoConstraints = false
        landscapeView2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(verticalButton)
        view.addSubview(horizontalButton1)
        view.addSubview(horizontalButton2)
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
        
        view.addConstraint(verticalButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(verticalButton.bottomAnchor.constraintEqualToAnchor(landscapeView1.topAnchor, constant: -100))
        
        view.addConstraint(horizontalButton1.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(horizontalButton1.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -90))
        
        view.addConstraint(horizontalButton2.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -90))
        view.addConstraint(horizontalButton2.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -90))
    }
}

