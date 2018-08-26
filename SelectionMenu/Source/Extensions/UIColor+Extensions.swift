//
//  UIColor+Extensions.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 14/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: CGFloat(alpha) / 255.0)
    }

    convenience init(hex: Int) {
        self.init(red: hex >> 16 & 0xFF,
                  green: hex >> 8 & 0xFF ,
                  blue: hex & 0xFF,
                  alpha: 0xFF)
    }
}
