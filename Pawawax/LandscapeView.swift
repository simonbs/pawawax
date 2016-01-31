//
//  LandscapeView.swift
//  Pawawax
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class LandscapeContainerView: FocusableView {
    let landscapeView = LandscapeView()
    
    override init() {
        super.init()
        landscapeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(landscapeView)
        addConstraint(landscapeView.leadingAnchor.constraintEqualToAnchor(leadingAnchor))
        addConstraint(landscapeView.trailingAnchor.constraintEqualToAnchor(trailingAnchor))
        addConstraint(landscapeView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(landscapeView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LandscapeView: Pawaview {
    override init() {
        super.init()
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFontOfSize(46)
        titleLabel.textColor = .whiteColor()
        titleLabel.text = "BEAUTIFUL"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backImageView = UIImageView(image: UIImage(named: "0"))
        let moonImageView = UIImageView(image: UIImage(named: "1"))
        let cloudsImageView = UIImageView(image: UIImage(named: "2"))
        let backMountainImageView = UIImageView(image: UIImage(named: "3"))
        let frontMountainsImageView = UIImageView(image: UIImage(named: "4"))
//        let backTreesImageView = UIImageView(image: UIImage(named: "5"))
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        moonImageView.translatesAutoresizingMaskIntoConstraints = false
        cloudsImageView.translatesAutoresizingMaskIntoConstraints = false
        backMountainImageView.translatesAutoresizingMaskIntoConstraints = false
        frontMountainsImageView.translatesAutoresizingMaskIntoConstraints = false
//        backTreesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(backImageView)
        contentView.addSubview(moonImageView)
        contentView.addSubview(cloudsImageView)
        contentView.addSubview(backMountainImageView)
        contentView.addSubview(frontMountainsImageView)
//        contentView.addSubview(backTreesImageView)
        contentView.addSubview(titleLabel)
        
        contentView.addConstraint(backImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(backImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(backImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(backImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(moonImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(moonImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(moonImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(moonImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(cloudsImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(cloudsImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(cloudsImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))

        contentView.addConstraint(backMountainImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(backMountainImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(backMountainImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(backMountainImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(frontMountainsImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(frontMountainsImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(frontMountainsImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))

//        contentView.addConstraint(backTreesImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
//        contentView.addConstraint(backTreesImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
//        contentView.addConstraint(backTreesImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(titleLabel.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor))
        contentView.addConstraint(titleLabel.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}