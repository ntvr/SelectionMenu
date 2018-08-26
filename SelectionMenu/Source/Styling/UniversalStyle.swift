//
//  UniversalStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 07/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

struct UniversalStyle {
    // Shared
    let circular: Bool
    // SelectionCollectionStyling
    let collectionBgColor: UIColor?
    let collectionHighightColor: UIColor?
    // SelectionElementStyling
    let selectedFgColor: UIColor?
    let selectedBgColor: UIColor?
    let deselectedFgColor: UIColor?
    let deselectedBgColor: UIColor?
}

// MARK: - SelectionCollectionStyling
extension UniversalStyle: SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView) {

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
    func apply(to element: SelectionElementView, selected: Bool) {

        element.circular = circular
        if circular {
            element.clipsToBounds = true
        }

        switch element {
        case let label as LabelSelectionElement:
            label.fgColor = selected ? selectedFgColor : deselectedFgColor
            label.bgColor = selected ? selectedBgColor : deselectedBgColor

        case let imageView as UIImageView:
            imageView.fgColor = selected ? selectedFgColor : deselectedFgColor
            imageView.bgColor = selected ? selectedBgColor : deselectedBgColor

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
extension UniversalStyle {
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
