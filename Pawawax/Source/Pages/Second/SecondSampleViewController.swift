//
//  SecondSampleViewController.swift
//  Pawawax
//
//  Created by Simon Støvring on 31/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class SecondSampleViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Second"
        edgesForExtendedLayout = .Bottom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parisVacationView = VacationView()
        let londonVacationView = VacationView()
        
        parisVacationView.translatesAutoresizingMaskIntoConstraints = false
        londonVacationView.translatesAutoresizingMaskIntoConstraints = false
        
        parisVacationView.titleLabel.text = "PARIS"
        londonVacationView.titleLabel.text = "LONDON"
        
        parisVacationView.imageView.image = UIImage(named: "paris")
        londonVacationView.imageView.image = UIImage(named: "london")
        
        view.addSubview(parisVacationView)
        view.addSubview(londonVacationView)
        
        view.addConstraint(parisVacationView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(parisVacationView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60))
        
        view.addConstraint(londonVacationView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -90))
        view.addConstraint(londonVacationView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60))
    }
}