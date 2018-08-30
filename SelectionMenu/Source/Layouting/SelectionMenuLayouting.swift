//
//  SelectionMenuLayouting.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 21/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public enum HorizontalAlignment {
    /// Fixed to left of the platform
    case left(inset: CGFloat)
    /// Fixed to right of the platform
    case right(inset: CGFloat)
    /// Center of menu button to center of menu
    case centerToCenter
    /// Left of menu button aligned with left of menu
    case leftToLeft
    /// Right of menu button aligned with right of menu
    case rightToRight
    /// Left of menu button aligned with right of menu
    case leftToRight
    /// Right of menu button aligned with left of menu
    case rightToLeft

    func apply(to make: ConstraintMaker, with menu: SelectionMenu, and platform: UIView) {
        switch self {
        case let .left(inset): make.left.equalTo(platform).inset(inset)
        case let .right(inset): make.right.equalTo(platform).inset(inset)
        case .centerToCenter: make.centerX.equalTo(menu)
        case .leftToLeft: make.left.equalTo(menu)
        case .rightToRight: make.right.equalTo(menu)
        case .leftToRight: make.right.equalTo(menu.snp.left)
        case .rightToLeft: make.left.equalTo(menu.snp.right)
        }
    }
}

public enum VerticalDirection {
    /// Next collection is placed above previous
    case up
    /// Next collection is placed below previous
    case down

    func apply(to make: ConstraintMaker, with previous: SelectionCollectionView, using spacing: CGFloat) {
        switch self {
        case .up: make.bottom.equalTo(previous.snp.top).offset(-spacing)
        case .down: make.top.equalTo(previous.snp.bottom).offset(spacing)
        }
    }
}

public enum VerticalAlignment {
    /// Fixed to top of the platform, always direction *down*
    case top(inset: CGFloat)
    /// Fixed to the bottom of the platform, always direction *up*
    case bottom(inset: CGFloat)
    /// Top of menu button to top of menu
    case topToTop(direction: VerticalDirection)
    /// Bottom of menu button to bottom of menu
    case bottomToBottom(direction: VerticalDirection)
    /// Top of menu button to bottom of menu
    case topToBottom(direction: VerticalDirection)
    /// Bottom of menu button to top of menu
    case bottomToTop(direction: VerticalDirection)

    /// Controls direction of laying out the `SelectionCollection`s.
    /// - `up`: The first `SelectionCollection` will be at the bottom and the last at the top.
    /// - `down`: The first `SelectionCollection` will be at the top and the last at the bottom.
    public var direction: VerticalDirection {
        switch self {
        case .top: return .down
        case .bottom: return .up
        case let .topToTop(direction),
             let .bottomToBottom(direction),
             let .topToBottom(direction),
             let .bottomToTop(direction):
            return direction
        }
    }

    /// Spacing is only applied on top/bottom/topToBottom/bottomToTop
    func apply(to make: ConstraintMaker, with menu: SelectionMenu, and platform: UIView, spacing: CGFloat) {
        // TODO: Refactor spacing
        switch self {
        case .top: make.top.equalTo(platform.snp.top).offset(spacing)
        case .bottom: make.bottom.equalTo(platform.snp.bottom).offset(-spacing)
        case .topToTop: make.top.equalTo(menu.snp.top)
        case .bottomToBottom: make.bottom.equalTo(menu.snp.bottom)
        case .topToBottom: make.bottom.equalTo(menu.snp.top).offset(-spacing)
        case .bottomToTop: make.top.equalTo(menu.snp.bottom).offset(spacing)
        }
    }
}

/// MARK: - SelectionMenuLayouting
public protocol SelectionMenuLayouting {
    // Layouout collection views
    func layoutCollections(menu: SelectionMenu, platform: UIView, collections: [SelectionCollectionView])
}
