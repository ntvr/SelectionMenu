//
//  UIEdgeInsets+Extensions.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}
