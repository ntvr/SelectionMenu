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

public struct ManualMenuLayout: SelectionMenuLayouting {
    
    /// Vertical spacing between collections.
    public var verticalSpacing: CGFloat

    /// Ratio of MenuButton to SelectionCollections (MenuButton.height / SelectionCollection.height).
    public var menuButtonHeightRatio: CGFloat

    /// Rule for horizontal alignment. For more information see HorizontalAlignment.
    public var horizontalAlignment: HorizontalAlignment

    /// Rule for vertical alignment. For more information see VerticalAlignment.
    public var verticalAlignment: VerticalAlignment

    /// Intializes ManualMenuLayout
    ///
    /// - Parameter verticalSpacing: Vertical spacing between collections.
    /// - Parameter menuButtonHeightRatio: Ratio of MenuButton to SelectionCollections (MenuButton.height / SelectionCollection.height).
    /// - Parameter horizontalAlignment: Rule for horizontal alignment. For more information see HorizontalAlignment.
    /// - Parameter verticalAlignment: Rule for vertical alignment. For more information see VerticalAlignment.
    public init(
        verticalSpacing: CGFloat = 10,
        menuButtonHeightRatio: CGFloat = 1.2,
        horizontalAlignment: HorizontalAlignment = .rightToRight,
        verticalAlignment: VerticalAlignment = .topToBottom(direction: .up))
    {
        self.verticalSpacing = verticalSpacing
        self.menuButtonHeightRatio = menuButtonHeightRatio
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
    }

    public func layoutCollections(menu: SelectionMenu, platform: UIView, collections: [SelectionCollectionView]) {
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
