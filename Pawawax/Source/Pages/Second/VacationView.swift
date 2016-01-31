//
//  VacationView.swift
//  Pawawax
//
//  Created by Simon Støvring on 31/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class VacationView: Pawaview {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init() {
        super.init()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFontOfSize(46)
        titleLabel.textColor = .whiteColor()
        titleLabel.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        titleLabel.shadowOffset = CGSize(width: 0, height: 2)
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        addConstraint(imageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor))
        addConstraint(imageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor))
        addConstraint(imageView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
        
        addConstraint(titleLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 60))
        addConstraint(titleLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -40))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canBecomeFocused() -> Bool {
        return true
    }
}