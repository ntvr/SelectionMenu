//
//  SelectionCollectionStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 23/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

struct SelectionCollectionStyle {
    var circular: Bool
    /// Only used for SingleSelectionCollection's markView circular property
    var circularMark: Bool

    /// Only used for SingleSelectionCollection's markView background color
    var markBackgroundColor: UIColor?
    var backgroundColor: UIColor?
}

// MARK: - SelectionCollectionStyling
extension SelectionCollectionStyle: SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView) {
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
