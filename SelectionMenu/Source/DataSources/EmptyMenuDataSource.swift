//
//  EmptyMenuDataSource.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Empty Menu data source.
///
/// Returns 0 from `selectionMenuNumberOfSections()` and `selectionMenu(numberOfElementsIn:)`
/// Throws `fatalError` in `selectionMenu(typeOf:)` and `selectionMenu(viewFor:, in:)`
public class EmptyDataSource: SelectionMenuDataSource {
    public var visualEffect: UIVisualEffect? = UIBlurEffect(style: .light)

    public init() { }

    public func selectionMenuNumberOfSections() -> Int {
        return 0
    }

    public func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType {
        fatalError("Should not get called as there are no sections/buttons")
    }

    public func selectionMenu(numberOfElementsIn section: Int) -> Int {
        return 0
    }

    public func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView {
        fatalError("Should not get called as there are no sections/buttons")
    }
}
