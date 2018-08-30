//
//  NoStyle.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 14/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation

/// Use this style if you do not want to apply any styles through Styling protocols.
public struct NoStyle {
    /// No values necessary, because NoStyle does not apply any styles.
    public init() { }
}

extension NoStyle: SelectionElementStyling {
    public func apply(to element: SelectionElementView, selected: Bool) { }
}

extension NoStyle: SelectionCollectionStyling {
    public func apply(to collection: SelectionCollectionView) { }
}
