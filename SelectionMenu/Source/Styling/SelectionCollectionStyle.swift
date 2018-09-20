//
//  SelectionCollectionStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 23/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Style that can be applied only to SelectionCollections.
public struct SelectionCollectionStyle {
    /// - Rounded corners to form cirlce if squared.
    /// - Corner radius is equal to half of shorter side.
    public let circular: Bool

    /// Controls SingleCollection's markView's backgroundColor.
    public let markBackgroundColor: UIColor?

    /// Controls SelectionCollection's background color.
    public let foregroundColor: UIColor?

    /// Controls SelectionCollection's background color.
    public let backgroundColor: UIColor?

    /// Initalizes SelectionCollectionStyle simply setting the properties with values provided.
    ///
    /// To inspect the impact of the values see SelectionCollectionStyle's properties
    public init(
        circular: Bool,
        markBackgroundColor: UIColor?,
        foregroundColor: UIColor?,
        backgroundColor: UIColor?)
    {
        self.circular = circular
        self.markBackgroundColor = markBackgroundColor
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}

// MARK: - SelectionCollectionStyling
extension SelectionCollectionStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {
        collection.circularStylable = circular
        collection.backgroundColorStylable = backgroundColor
        collection.foregroundColorStylable = foregroundColor
    }
}
