//
//  UIButton+SelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

extension UIButton: SelectionElement {
    // Necessary methods are implemented by UIButton+MenuButton
    public var foregroundColorStylable: UIColor? {
        get { return titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }

    public var backgroundColorStylable: UIColor? {
        get { return nil } // FIXME: Cannot determine color from image
        set { setImage(UIImage(of: newValue ?? .clear), for: .normal) }
    }

    public var circularStylable: Bool {
        get { return circular }
        set { circular = newValue }
    }

    public var shadowedLayerStylable: CALayer? {
        return layer
    }
}
