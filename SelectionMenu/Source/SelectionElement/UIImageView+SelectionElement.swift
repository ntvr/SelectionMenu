//
//  UIImageView+SelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView: SelectionElement {
    var fgColor: UIColor? {
        get { return tintColor }
        set { tintColor = newValue }
    }

    var bgColor: UIColor? {
        get { return backgroundColor }
        set { backgroundColor = newValue }
    }

    func expand() { }
    func collapse() { }
}
