//
//  PredefinedSelectionMenu.swift
//  FBSnapshotTestCase
//
//  Created by Michal Štembera on 24/09/2018.
//

import Foundation

public extension SelectionMenu {
    private static func menuButton(fg fgColor: UIColor, bg bgColor: UIColor) -> MenuButtonView {
        let button = UIButton(type: .custom)
        button.setTitle("Menu", for: .normal)
        button.circularStylable = true
        button.foregroundColorStylable = fgColor
        button.backgroundColorStylable = bgColor
        return button
    }

    public static var coolBlues: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: CoolBlues.deepAqua)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .white,
                                                  selectedBgColor: CoolBlues.deepAqua,
                                                  deselectedFgColor: CoolBlues.seafoam,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: CoolBlues.deepAqua,
                                                        backgroundColor: CoolBlues.ocean)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }
}
