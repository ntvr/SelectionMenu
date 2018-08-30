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

    /// Controls SingleCollection's markView circularity.
    public let circularMark: Bool

    /// Controls SingleCollection's markView's backgroundColor.
    public let markBackgroundColor: UIColor?

    /// Controls SelectionCollection's background color.
    public let backgroundColor: UIColor?

    /// Initalizes SelectionCollectionStyle simply setting the properties with values provided.
    ///
    /// To inspect the impact of the values see SelectionCollectionStyle's properties
    public init(
        circular: Bool,
        circularMark: Bool,
        markBackgroundColor: UIColor?,
        backgroundColor: UIColor?)
    {
        self.circular = circular
        self.circularMark = circularMark
        self.markBackgroundColor = markBackgroundColor
        self.backgroundColor = backgroundColor
    }
}

// MARK: - SelectionCollectionStyling
extension SelectionCollectionStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {
        switch collection {
        case let single as SingleSelectionCollection:
            single.backgroundView.circular = circular
            single.backgroundView.backgroundColor = backgroundColor
            single.markView.circular = circular
            single.markView?.backgroundColor = markBackgroundColor

        case let multi as MultiSelectionCollection:
            multi.circular = circular
            multi.backgroundView.circular = circular
            multi.backgroundView.backgroundColor = backgroundColor

        case let button as ButtonSelectionCollection:
            button.circular = circular
            button.backgroundView.circular = circular
            button.backgroundView.backgroundColor = backgroundColor

        default:
            print("\(#file), \(#function): Unknown SelectionCollection type.")
        }
    }
}
