//
//  NoStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 14/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation

/// Use this style if you do not want to apply any styles through Styling protocols.
struct NoStyle {
}

extension NoStyle: SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool) { }
}

extension NoStyle: SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView) { }
}
