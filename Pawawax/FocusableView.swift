//
//  FocusableView.swift
//  Pawawax
//
//  Created by Simon Støvring on 30/01/2016.
//  Copyright © 2016 SimonBS. All rights reserved.
//

import Foundation
import UIKit

class FocusableView: UIView {
    init() {
        super.init(frame: CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canBecomeFocused() -> Bool {
        return true
    }
}