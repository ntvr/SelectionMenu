//
//  UIViewExtensions.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

extension UIView {
    private struct AssociatedKeys {
        static var RoundedCornerObserverKey = "rounded_corner_observer"
    }

    class func circularCornerRadius(from frame: CGRect) -> CGFloat {
        return min(frame.size.width / 2, frame.size.height / 2)
    }

    var circular: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.RoundedCornerObserverKey) == nil }
        set {
            if newValue {
                layer.cornerRadius = UIView.circularCornerRadius(from: bounds)
                let observer = self.observe(\.bounds, options: NSKeyValueObservingOptions.new) { view, value in
                    if let bounds = value.newValue {
                        view.layer.cornerRadius = UIView.circularCornerRadius(from: bounds)
                    }
                }
                objc_setAssociatedObject(self,
                                         &AssociatedKeys.RoundedCornerObserverKey,
                                         observer, .OBJC_ASSOCIATION_RETAIN)
            } else {
                objc_setAssociatedObject(self,
                                         &AssociatedKeys.RoundedCornerObserverKey,
                                         nil,
                                         .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
