//
//  SelectionElementStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 22/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

struct SelectionElementStyle {
    public var circular = true

    // LabelSelectionElement styling
    public let normalLabelBgColor: UIColor
    public let normalLabelFgColor: UIColor
    public let selectedLabelFgColor: UIColor
    public let selectedLabelBgColor: UIColor
    public let labelShadowStyle: SelectionElementStyling

    // UIImageView styling
    public let normalImageViewFgColor: UIColor
    public let normalImageViewBgColor: UIColor
    public let selectedImageViewFgColor: UIColor
    public let selectedImageViewBgColor: UIColor
    public let imageViewShadowStyle: SelectionElementStyling

    // UIButton styling
    public let normalButtonFgColor: UIColor
    public let normalButtonBgColor: UIColor
    public let highlightedButtonFgColor: UIColor
    public let highlightedButtonBgColor: UIColor
    public let buttonShadowStyle: SelectionElementStyling

    public init(
        normalLabelBgColor: UIColor,
        normalLabelFgColor: UIColor,
        selectedLabelFgColor: UIColor,
        selectedLabelBgColor: UIColor,
        labelShadowStyle: SelectionElementStyling,
        normalImageViewFgColor: UIColor,
        normalImageViewBgColor: UIColor,
        selectedImageViewFgColor: UIColor,
        selectedImageViewBgColor: UIColor,
        imageViewShadowStyle: SelectionElementStyling,
        normalButtonFgColor: UIColor,
        normalButtonBgColor: UIColor,
        highlightedButtonFgColor: UIColor,
        highlightedButtonBgColor: UIColor,
        buttonShadowStyle: SelectionElementStyling)
    {
        self.normalLabelBgColor = normalLabelBgColor
        self.normalLabelFgColor = normalLabelFgColor
        self.selectedLabelFgColor = selectedLabelFgColor
        self.selectedLabelBgColor = selectedLabelBgColor
        self.labelShadowStyle = labelShadowStyle
        self.normalImageViewFgColor = normalImageViewFgColor
        self.normalImageViewBgColor = normalImageViewBgColor
        self.selectedImageViewFgColor = selectedImageViewFgColor
        self.selectedImageViewBgColor = selectedImageViewBgColor
        self.imageViewShadowStyle = imageViewShadowStyle
        self.normalButtonFgColor = normalButtonFgColor
        self.normalButtonBgColor = normalButtonBgColor
        self.highlightedButtonFgColor = highlightedButtonFgColor
        self.highlightedButtonBgColor = highlightedButtonBgColor
        self.buttonShadowStyle = buttonShadowStyle
    }
}

// MARK: - SelectionElementStyling
extension SelectionElementStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, selected: Bool) {
        element.circular = circular
        if circular {
            element.clipsToBounds = true
        }

        switch element {
        case let labelElement as LabelSelectionElement:
            labelElement.label.textColor = selected ? selectedLabelFgColor : normalLabelFgColor
            labelElement.backgroundColor = selected ? selectedLabelBgColor : normalLabelBgColor
            labelShadowStyle.apply(to: labelElement, selected: selected)

        case let imageView as UIImageView:
            imageView.tintColor = selected ? selectedImageViewFgColor : normalImageViewFgColor
            imageView.backgroundColor = selected ? selectedImageViewBgColor : normalImageViewBgColor
            imageViewShadowStyle.apply(to: imageView, selected: selected)

        case let button as UIButton:
            button.setTitleColor(normalButtonFgColor, for: .normal)
            button.setTitleColor(highlightedButtonFgColor, for: .highlighted)
            button.tintColor = normalButtonFgColor
            let normalImage = UIImage(of: normalButtonBgColor)
            button.setBackgroundImage(normalImage, for: .normal)
            let highilghtedImage = UIImage(of: highlightedButtonBgColor)
            button.setBackgroundImage(highilghtedImage, for: .highlighted)
            buttonShadowStyle.apply(to: button, selected: selected)

        default:
            print("\(#file), \(#function): Unknown SelectionElementView type.")
        }
    }
}
