//
//  StaticMenuLayout.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 21/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

struct StaticMenuLayout: SelectionMenuLayouting {
    var verticalSpacing: CGFloat = 10
    var menuButtonHeightRatio: CGFloat = 1.2

    var horizontalAlignment: HorizontalAlignment = .rightToRight
    var verticalAlignment: VerticalAlignment = .topToBottom(direction: .up)

    func layoutCollections(menu: SelectionMenu, platform: UIView, collections: [SelectionCollectionView]) {
        var previousCollection: SelectionCollectionView!
        if let collection = collections.first {
            collection.snp.remakeConstraints { make in
                horizontalAlignment.apply(to: make, with: menu, and: platform)
                verticalAlignment.apply(to: make, with: menu, and: platform,
                                        spacing: verticalSpacing * menuButtonHeightRatio)
                make.height.equalTo(menu).dividedBy(menuButtonHeightRatio)
            }

            previousCollection = collection
        }

        collections.dropFirst().forEach { collection in
            collection.snp.remakeConstraints { make in
                horizontalAlignment.apply(to: make, with: menu, and: platform)
                verticalAlignment.direction.apply(to: make, with: previousCollection, using: verticalSpacing)
                make.height.equalTo(menu).dividedBy(menuButtonHeightRatio)
            }

            previousCollection = collection
        }
    }
}
