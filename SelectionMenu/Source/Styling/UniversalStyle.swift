//
//  UniversalStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 07/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

public struct UniversalStyle {
    // Shared
    public let circular: Bool
    // SelectionCollectionStyling
    public let collectionBgColor: UIColor?
    public let collectionHighightColor: UIColor?
    // SelectionElementStyling
    public let selectedFgColor: UIColor?
    public let selectedBgColor: UIColor?
    public let deselectedFgColor: UIColor?
    public let deselectedBgColor: UIColor?

    public init(
        circular: Bool,
        collectionBgColor: UIColor?,
        collectionHighightColor: UIColor?,
        selectedFgColor: UIColor?,
        selectedBgColor: UIColor?,
        deselectedFgColor: UIColor?,
        deselectedBgColor: UIColor?
    ) {
        self.circular = circular
        self.collectionBgColor = collectionBgColor
        self.collectionHighightColor = collectionHighightColor
        self.selectedFgColor = selectedFgColor
        self.selectedBgColor = selectedBgColor
        self.deselectedFgColor = deselectedFgColor
        self.deselectedBgColor = deselectedBgColor
    }
}

// MARK: - SelectionCollectionStyling
extension UniversalStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) {

        switch collection {
        case let single as SingleSelectionCollection:
            single.backgroundView.circular = circular
            single.markView.circular = circular
            single.backgroundView.backgroundColor = collectionBgColor
            single.highlightColor = collectionHighightColor

        case let multi as MultiSelectionCollection:
            multi.circular = circular
            multi.backgroundView.circular = circular
            multi.backgroundView.backgroundColor = collectionBgColor

        case let button as ButtonSelectionCollection:
            button.circular = circular
            button.backgroundView.circular = circular
            button.backgroundView.backgroundColor = collectionBgColor

        default:
            collection.circular = circular
            collection.backgroundColor = collectionBgColor
        }
    }
}

// MARK: - SelectionElementStyling
extension UniversalStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, selected: Bool) {

        element.circular = circular
        if circular {
            element.clipsToBounds = true
        }

        switch element {
        case let label as LabelSelectionElement:
            label.label.textColor = selected ? selectedFgColor : deselectedFgColor
            label.label.backgroundColor = selected ? selectedBgColor : deselectedBgColor

        case let imageView as UIImageView:
            imageView.tintColor = selected ? selectedFgColor : deselectedFgColor
            imageView.backgroundColor = selected ? selectedBgColor : deselectedBgColor

        case let button as UIButton:
            button.setTitleColor(deselectedFgColor, for: .normal)
            button.setTitleColor(selectedFgColor, for: .highlighted)
            let deselectedImage = UIImage(of: deselectedBgColor ?? .clear)
            button.setBackgroundImage(deselectedImage, for: .normal)
            let selectedImage = UIImage(of: selectedBgColor ?? .clear)
            button.setBackgroundImage(selectedImage, for: .highlighted)

        default:
            element.circular = circular
            element.backgroundColor = selected ? selectedBgColor : deselectedBgColor
        }
    }
}

// MARK: - ColorSpace
public extension UniversalStyle {
    static var blackWhite = UniversalStyle(
        circular: true,
        collectionBgColor: .white,
        collectionHighightColor: .lightGray,
        selectedFgColor: .black,
        selectedBgColor: .clear,
        deselectedFgColor: .darkGray,
        deselectedBgColor: .clear
    )

    static var redWhite = UniversalStyle(
        circular: true,
        collectionBgColor: .white,
        collectionHighightColor: .lightGray,
        selectedFgColor: .red,
        selectedBgColor: .clear,
        deselectedFgColor: .darkGray,
        deselectedBgColor: .clear
    )

    static var bluish = UniversalStyle(
        circular: true,
        collectionBgColor: UIColor(hex: 0x0E5FD1),
        collectionHighightColor: UIColor(hex: 0x4064E5),
        selectedFgColor: UIColor(hex: 0xFCF123),
        selectedBgColor: .clear,
        deselectedFgColor: UIColor(hex: 0xFFF6BC),
        deselectedBgColor: .clear
    )
}
