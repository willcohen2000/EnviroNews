//
//  Customization.swift
//  EnvironNews
//
//  Created by Will Cohen on 11/18/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class Customization {
    
    static func loginTextFieldCustomization(TF: UITextField) {
        TF.layer.cornerRadius = TF.frame.height / 2;
        TF.layer.borderColor = UIColor.white.cgColor;
        TF.layer.borderWidth = 0.5;
    }
    
}
