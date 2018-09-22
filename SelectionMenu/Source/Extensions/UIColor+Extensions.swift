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

    func lightened(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }

    func darkened(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        let ratio = (0...100).clamp(percentage) / 100
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + ratio, 1.0),
                           green: min(green + ratio, 1.0),
                           blue: min(blue + ratio, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
