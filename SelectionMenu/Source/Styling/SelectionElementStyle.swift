//
//  SelectionElementStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Style that can be applied only to SelectionElements.
public class SelectionElementStyle {
    /// - Rounded corners to form cirlce if squared.
    /// - Corner radius is equal to half of shorter side.
    public var circular = true

    /// - Controls SelectionElement's foreground color
    /// - Will be applied through `SelectionElement.foregroundColorStylable`
    /// - Only applied only when element is **selected**
    public let selectedFgColor: UIColor?

    /// - Controls SelectionElement's background color
    /// - Will be applied through `SelectionElement.backgroundColorStylable`
    /// - Only applied only when element is **selected**
    public let selectedBgColor: UIColor?

    /// - Controls SelectionElement's foreground color
    /// - Will be applied through `SelectionElement.foregroundColorStylable`
    /// - Only applied only when element is **not selected**
    public let deselectedFgColor: UIColor?

    /// - Controls SelectionElement's background color
    /// - Will be applied through `SelectionElement.backgroundColorStylable`
    /// - Only applied only when element is **not selected**
    public let deselectedBgColor: UIColor?

    /// Initializes SelectionElementStyle
    ///
    /// To review parameters read properties documentation
    public init(
        circular: Bool = true,
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
}

// MARK: - SelectionElementStyling
extension SelectionElementStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, in sectionType: SelectionMenu.SectionType, selected: Bool) {

        element.circularStylable = circular

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
