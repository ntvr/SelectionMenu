//
//  EmptyMenuDataSource.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

class EmptyDataSource: SelectionMenuDataSource {
    var visualEffect: UIVisualEffect? = UIBlurEffect(style: .light)

    func selectionMenuNumberOfSections() -> Int {
        return 0
    }

    func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType {
        return .singleSelection(selected: 0)
    }

    func selectionMenu(numberOfElementsIn section: Int) -> Int {
        return 0
    }

    func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView {
        fatalError("Should not get called as there are no sections/buttons")
    }
}
