//
//  LandscapeView.swift
//  Pawawax
//
//  Created by Simon Støvring on 29/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class LandscapeView: Pawaview {
    override init() {
        super.init()
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFontOfSize(46)
        titleLabel.textColor = .whiteColor()
        titleLabel.text = "BEAUTIFUL"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backImageView = UIImageView(image: UIImage(named: "0"))
        let backMountainImageView = UIImageView(image: UIImage(named: "1"))
        let frontMountainsImageView = UIImageView(image: UIImage(named: "2"))
        let backTreesImageView = UIImageView(image: UIImage(named: "3"))
//        let frontTreesImageView = UIImageView(image: UIImage(named: "4"))
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backMountainImageView.translatesAutoresizingMaskIntoConstraints = false
        frontMountainsImageView.translatesAutoresizingMaskIntoConstraints = false
        backTreesImageView.translatesAutoresizingMaskIntoConstraints = false
//        frontTreesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(backImageView)
        contentView.addSubview(backMountainImageView)
        contentView.addSubview(frontMountainsImageView)
        contentView.addSubview(backTreesImageView)
//        contentView.addSubview(frontTreesImageView)
        contentView.addSubview(titleLabel)
        
        contentView.addConstraint(backImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(backImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(backImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(backImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(backMountainImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(backMountainImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(backMountainImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(backMountainImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(frontMountainsImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(frontMountainsImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(frontMountainsImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(backTreesImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(backTreesImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(backTreesImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
//        contentView.addConstraint(frontTreesImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
//        contentView.addConstraint(frontTreesImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
//        contentView.addConstraint(frontTreesImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
        
        contentView.addConstraint(titleLabel.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor))
        contentView.addConstraint(titleLabel.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}