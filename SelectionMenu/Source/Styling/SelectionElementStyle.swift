//
//  SelectionElementStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Style that can be applied only to SelectionElement.
public struct SelectionElementStyle {
    /// - Rounded corners to form cirlce if squared.
    /// - Corner radius is equal to half of shorter side.
    public var circular = true

    public let selectedFgColor: UIColor?
    public let selectedBgColor: UIColor?
    public let deselectedFgColor: UIColor?
    public let deselectedBgColor: UIColor?

    public init(
        selectedFgColor: UIColor?,
        selectedBgColor: UIColor?,
        deselectedFgColor: UIColor?,
        deselectedBgColor: UIColor?)
    {
        self.selectedFgColor = selectedFgColor
        self.selectedBgColor = selectedBgColor
        self.deselectedFgColor = deselectedFgColor
        self.deselectedBgColor = deselectedBgColor
    }

    public init(circular: Bool = true,
                contentColor: UIColor?,
                baseColor: UIColor?)
    {
        selectedFgColor = contentColor
        selectedBgColor = baseColor?.darker()
        deselectedFgColor = contentColor?.darker()
        deselectedBgColor = .clear
    }
}

// MARK: - SelectionElementStyling
extension SelectionElementStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, in sectionType: SelectionMenu.SectionType, selected: Bool) {

        element.circular = circular

        if selected {
            element.foregroundColorStylable = selectedFgColor
        } else {
            element.foregroundColorStylable = deselectedFgColor
        }

        switch (sectionType, selected) {
        case (.singleSelection, _): break
        case (.multiSelection, true), (.buttonSelection, true):
            element.backgroundColorStylable = selectedBgColor
        case (.multiSelection, false), (.buttonSelection, false):
            element.backgroundColorStylable = deselectedBgColor
        }
    }
}
