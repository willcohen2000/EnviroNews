//
//  Colors.swift
//  EnvironNews
//
//  Created by Will Cohen on 12/4/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    static let offWhiteColor = UIColor(red:0.85, green:0.85, blue:0.83, alpha:1.0);
    static let centralGreenColor = UIColor(red:0.15, green:0.65, blue:0.36, alpha:1.0);
    static let offGreenColor = UIColor(red:0.15, green:0.65, blue:0.36, alpha:0.5);
    static let offBlackColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.0);
    
    static func hexToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased();
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex);
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray;
        }
        
        var rgbValue:UInt32 = 0;
        Scanner(string: cString).scanHexInt32(&rgbValue);
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        );
    }
    
}
