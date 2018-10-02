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
public class SelectionCollectionStyle {
    /// - Rounded corners to form cirlce if squared.
    /// - Corner radius is equal to half of shorter side.
    public let circular: Bool

    /// - Controls SelectionCollection's background color
    /// - Will be applied through `Stylable.foregroundColorStylable`
    public let foregroundColor: UIColor?

    /// - Controls SelectionCollection's background color.
    /// - Will be applied through `Stylable.backgroundColorStylable`
    public let backgroundColor: UIColor?

    /// Initalizes SelectionCollectionStyle simply setting the properties with values provided.
    ///
    /// To inspect the impact of the values see SelectionCollectionStyle's properties
    public init(
        circular: Bool,
        foregroundColor: UIColor?,
        backgroundColor: UIColor?)
    {
        self.circular = circular
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}

// MARK: - SelectionCollectionStyling
extension SelectionCollectionStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {
        collection.circularStylable = circular
        collection.foregroundColorStylable = foregroundColor
        collection.backgroundColorStylable = backgroundColor
    }
}
