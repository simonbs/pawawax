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
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        let landscapeView1 = LandscapeContainerView()
        let landscapeView2 = LandscapeContainerView()

        landscapeView1.translatesAutoresizingMaskIntoConstraints = false
        landscapeView2.translatesAutoresizingMaskIntoConstraints = false
        
        let landscapeViewImageView1 = UIImageView(image: UIImage(named: "landscape"))
        let landscapeViewImageView2 = UIImageView(image: UIImage(named: "landscape"))
        
        landscapeViewImageView1.translatesAutoresizingMaskIntoConstraints = false
        landscapeViewImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        landscapeViewImageView1.adjustsImageWhenAncestorFocused = true
        landscapeViewImageView2.adjustsImageWhenAncestorFocused = true
        
        let landscapeImageContainerView1 = FocusableView()
        let landscapeImageContainerView2 = FocusableView()
        
        landscapeImageContainerView1.translatesAutoresizingMaskIntoConstraints = false
        landscapeImageContainerView2.translatesAutoresizingMaskIntoConstraints = false
        
        landscapeImageContainerView1.addSubview(landscapeViewImageView1)
        landscapeImageContainerView2.addSubview(landscapeViewImageView2)
        
        contentView.addSubview(verticalButton)
        contentView.addSubview(horizontalButton1)
        contentView.addSubview(horizontalButton2)
        contentView.addSubview(landscapeView1)
        contentView.addSubview(landscapeView2)
        contentView.addSubview(landscapeImageContainerView1)
        contentView.addSubview(landscapeImageContainerView2)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        view.addConstraint(scrollView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor))
        view.addConstraint(scrollView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor))
        view.addConstraint(scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor))
        view.addConstraint(scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
        
        scrollView.addConstraint(contentView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor))
        scrollView.addConstraint(contentView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor))
        scrollView.addConstraint(contentView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor))
        scrollView.addConstraint(contentView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor))
        scrollView.addConstraint(contentView.widthAnchor.constraintEqualToAnchor(scrollView.widthAnchor))
        
        contentView.addConstraint(verticalButton.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 90))
        contentView.addConstraint(verticalButton.topAnchor.constraintEqualToAnchor(contentView.topAnchor, constant: 90))
        
        contentView.addConstraint(landscapeView1.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 90))
        contentView.addConstraint(landscapeView1.topAnchor.constraintEqualToAnchor(verticalButton.bottomAnchor, constant: 60))
        contentView.addConstraint(landscapeView1.widthAnchor.constraintEqualToConstant(816))
        contentView.addConstraint(landscapeView1.heightAnchor.constraintEqualToConstant(480))
        
        contentView.addConstraint(landscapeView2.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -90))
        contentView.addConstraint(landscapeView2.topAnchor.constraintEqualToAnchor(landscapeView1.topAnchor))
        contentView.addConstraint(landscapeView2.widthAnchor.constraintEqualToConstant(816))
        contentView.addConstraint(landscapeView2.heightAnchor.constraintEqualToConstant(480))
        
        contentView.addConstraint(horizontalButton1.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 90))
        contentView.addConstraint(horizontalButton1.topAnchor.constraintEqualToAnchor(landscapeView1.bottomAnchor, constant: 60))
        
        contentView.addConstraint(horizontalButton2.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -60))
        contentView.addConstraint(horizontalButton2.topAnchor.constraintEqualToAnchor(horizontalButton1.topAnchor))
        
        landscapeImageContainerView1.addConstraint(landscapeViewImageView1.leadingAnchor.constraintEqualToAnchor(landscapeImageContainerView1.leadingAnchor))
        landscapeImageContainerView1.addConstraint(landscapeViewImageView1.trailingAnchor.constraintEqualToAnchor(landscapeImageContainerView1.trailingAnchor))
        landscapeImageContainerView1.addConstraint(landscapeViewImageView1.topAnchor.constraintEqualToAnchor(landscapeImageContainerView1.topAnchor))
        landscapeImageContainerView1.addConstraint(landscapeViewImageView1.bottomAnchor.constraintEqualToAnchor(landscapeImageContainerView1.bottomAnchor))
        
        landscapeImageContainerView2.addConstraint(landscapeViewImageView2.leadingAnchor.constraintEqualToAnchor(landscapeImageContainerView2.leadingAnchor))
        landscapeImageContainerView2.addConstraint(landscapeViewImageView2.trailingAnchor.constraintEqualToAnchor(landscapeImageContainerView2.trailingAnchor))
        landscapeImageContainerView2.addConstraint(landscapeViewImageView2.topAnchor.constraintEqualToAnchor(landscapeImageContainerView2.topAnchor))
        landscapeImageContainerView2.addConstraint(landscapeViewImageView2.bottomAnchor.constraintEqualToAnchor(landscapeImageContainerView2.bottomAnchor))
        
        contentView.addConstraint(landscapeImageContainerView1.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 90))
        contentView.addConstraint(landscapeImageContainerView1.topAnchor.constraintEqualToAnchor(horizontalButton1.bottomAnchor, constant: 60))
        contentView.addConstraint(landscapeImageContainerView1.widthAnchor.constraintEqualToConstant(816))
        contentView.addConstraint(landscapeImageContainerView1.heightAnchor.constraintEqualToConstant(480))
        
        contentView.addConstraint(landscapeImageContainerView2.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor, constant: -90))
        contentView.addConstraint(landscapeImageContainerView2.topAnchor.constraintEqualToAnchor(landscapeImageContainerView1.topAnchor))
        contentView.addConstraint(landscapeImageContainerView2.widthAnchor.constraintEqualToConstant(816))
        contentView.addConstraint(landscapeImageContainerView2.heightAnchor.constraintEqualToConstant(480))
        
        contentView.addConstraint(landscapeImageContainerView1.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor, constant: -90))
    }
}

