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
    var circular = true

    // LabelSelectionElement styling
    let normalLabelFgColor: UIColor
    let normalLabelBgColor: UIColor
    let selectedLabelFgColor: UIColor
    let selectedLabelBgColor: UIColor
    let labelShadowStyle: SelectionElementStyling

    // UIImageView styling
    let normalImageViewFgColor: UIColor
    let normalImageViewBgColor: UIColor
    let selectedImageViewFgColor: UIColor
    let selectedImageViewBgColor: UIColor
    let imageViewShadowStyle: SelectionElementStyling

    // UIButton styling
    let normalButtonFgColor: UIColor
    let normalButtonBgColor: UIColor
    let highlightedButtonFgColor: UIColor
    let highlightedButtonBgColor: UIColor
    let buttonShadowStyle: SelectionElementStyling
}

extension SelectionElementStyle: SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool) {
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
