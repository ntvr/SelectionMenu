//
//  AutomaticMenuLayout.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 21/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public struct AutomaticMenuLayout: SelectionMenuLayouting {
    public var verticalSpacing: CGFloat
    public var menuButtonHeightRatio: CGFloat

    public init(
        verticalSpacing: CGFloat = 5,
        menuButtonHeightRatio: CGFloat = 1.3
    ) {
        self.verticalSpacing = verticalSpacing
        self.menuButtonHeightRatio = menuButtonHeightRatio
    }

    func prepare(menu: SelectionMenu, platform: UIView) -> SelectionMenuLayouting {
        let top = menu.frame.minY
        let left = menu.frame.minX
        let bottom = platform.bounds.maxY - menu.frame.maxY
        let right = platform.bounds.maxX - menu.frame.maxX

        var horizontal: HorizontalAlignment
        switch left / right {
        case 0.95...1.05: horizontal = .centerToCenter
        case ..<1: horizontal = .leftToLeft
        default: horizontal = .rightToRight
        }

        var vertical: VerticalAlignment
        switch bottom / top {
        case ..<1: vertical = .topToBottom(direction: .up)
        default: vertical = .bottomToTop(direction: .down)
        }

        return ManualMenuLayout(verticalSpacing: verticalSpacing,
                                menuButtonHeightRatio: menuButtonHeightRatio,
                                horizontalAlignment: horizontal,
                                verticalAlignment: vertical)
    }

    public func layoutCollections(menu: SelectionMenu, platform: UIView, collections: [SelectionCollectionView]) {
        let preparedLayout = prepare(menu: menu, platform: platform)
        preparedLayout.layoutCollections(menu: menu, platform: platform, collections: collections)
    }
}
