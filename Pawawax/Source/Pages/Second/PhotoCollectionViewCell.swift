//
//  PhotoCollectionViewCell.swift
//  Pawawax
//
//  Created by Simon Støvring on 31/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let vacationView = VacationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        vacationView.titleLabel.font = .boldSystemFontOfSize(62)
        vacationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(vacationView)
        contentView.addConstraint(vacationView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor))
        contentView.addConstraint(vacationView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor))
        contentView.addConstraint(vacationView.topAnchor.constraintEqualToAnchor(contentView.topAnchor))
        contentView.addConstraint(vacationView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}