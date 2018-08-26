//
//  UIButtonExtension.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIButton
extension UIButton: MenuButton {
    var tapEnabled: Bool {
        get { return isEnabled }
        set { isEnabled = newValue }
    }

    func addTargetForTapGesture(target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }

    func expand() { }

    func collapse() { }
}
