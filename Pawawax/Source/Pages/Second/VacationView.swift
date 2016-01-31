//
//  VacationView.swift
//  Pawawax
//
//  Created by Simon Støvring on 31/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class VacationContainerView: FocusableView {
    let vacationView = VacationView()
    
    override init() {
        super.init()
        vacationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vacationView)
        addConstraint(vacationView.leadingAnchor.constraintEqualToAnchor(leadingAnchor))
        addConstraint(vacationView.trailingAnchor.constraintEqualToAnchor(trailingAnchor))
        addConstraint(vacationView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(vacationView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VacationView: Pawaview {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override init() {
        super.init()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFontOfSize(120)
        titleLabel.textColor = .whiteColor()
        titleLabel.numberOfLines = 0
        titleLabel.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        titleLabel.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        addConstraint(imageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor))
        addConstraint(imageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor))
        addConstraint(imageView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))

        addConstraint(titleLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 40))
        addConstraint(titleLabel.trailingAnchor.constraintLessThanOrEqualToAnchor(trailingAnchor, constant: -40))
        addConstraint(titleLabel.bottomAnchor.constraintEqualToAnchor(bottomAnchor, constant: -20))
        
        imageView.setContentHuggingPriority(1000, forAxis: .Horizontal)
        imageView.setContentHuggingPriority(1000, forAxis: .Vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}