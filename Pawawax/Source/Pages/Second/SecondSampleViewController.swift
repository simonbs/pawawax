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
        
        let parisVacationView = VacationContainerView()
        let londonVacationView = VacationContainerView()
        let romeVacationView = VacationContainerView()
        
        parisVacationView.translatesAutoresizingMaskIntoConstraints = false
        londonVacationView.translatesAutoresizingMaskIntoConstraints = false
        romeVacationView.translatesAutoresizingMaskIntoConstraints = false
        
        parisVacationView.vacationView.titleLabel.text = "PARIS"
        londonVacationView.vacationView.titleLabel.text = "LON\nDON"
        romeVacationView.vacationView.titleLabel.text = "ROME"
        
        parisVacationView.vacationView.imageView.image = UIImage(named: "paris")
        londonVacationView.vacationView.imageView.image = UIImage(named: "london")
        romeVacationView.vacationView.imageView.image = UIImage(named: "rome")
        
        let photosController = PhotosViewController()
        photosController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(photosController)
        view.addSubview(photosController.view)
        photosController.didMoveToParentViewController(self)
        
        view.addSubview(parisVacationView)
        view.addSubview(londonVacationView)
        view.addSubview(romeVacationView)
        
        view.addConstraint(parisVacationView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 90))
        view.addConstraint(parisVacationView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60))
        
        view.addConstraint(londonVacationView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        view.addConstraint(londonVacationView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60))
        
        view.addConstraint(romeVacationView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -90))
        view.addConstraint(romeVacationView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 60))
        
        view.addConstraint(photosController.view.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor))
        view.addConstraint(photosController.view.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor))
        view.addConstraint(photosController.view.topAnchor.constraintEqualToAnchor(parisVacationView.bottomAnchor, constant: 60))
        view.addConstraint(photosController.view.heightAnchor.constraintEqualToConstant(400))
    }
}