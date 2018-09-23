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
    var rgbaString: String? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return "Cannot get RGBA components"
        }

        return "r: \(red * 255), g: \(green * 255), b: \(blue * 255) a: \(alpha * 255)"
    }

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

// MARK: - Adjusting color brightness
extension UIColor {
    /**
     Create a ligher color
     */
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }

    /**
     Create a darker color
     */
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }

    /**
     Try to increase brightness or decrease saturation
     */
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                /**
                 Below is the new part, which makes the code work with black as well as colors
                 */
                let newB: CGFloat
                if b == 0.0 {
                    newB = max(min(b + percentage/100, 1.0), 0.0)
                } else {
                    newB = max(min(b + (percentage/100.0)*b, 1.0), 0,0)
                }
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}
