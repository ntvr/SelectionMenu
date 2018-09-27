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

    public static var red: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: .red)
        let menu = SelectionMenu(menuButton: button)
        menu.elementStyle = SelectionElementStyle.red
        menu.collectionStyle = SelectionCollectionStyle.red
        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToLeft(spacing: 10),
            verticalAlignment: .topToBottom(direction: .up)
        )
        return menu
    }

    public static var green: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: .green)
        let menu = SelectionMenu(menuButton: button)
        menu.elementStyle = SelectionElementStyle.green
        menu.collectionStyle = SelectionCollectionStyle.green
        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )
        return menu
    }

    public static var blue: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: .blue)
        let menu = SelectionMenu(menuButton: button)
        menu.elementStyle = SelectionElementStyle.blue
        menu.collectionStyle = SelectionCollectionStyle.blue
        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToLeft(spacing: 10),
            verticalAlignment: .centerToCenter(direction: .up)
        )
        return menu
    }

    public static var black: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: .black)
        let menu = SelectionMenu(menuButton: button)
        menu.elementStyle = SelectionElementStyle.black
        menu.collectionStyle = SelectionCollectionStyle.black
        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .centerToCenter,
            verticalAlignment: .bottomToTop(direction: .down)
        )
        return menu
    }

    public static var white: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .black, bg: .white)
        let menu = SelectionMenu(menuButton: button)
        menu.elementStyle = SelectionElementStyle.white
        menu.collectionStyle = SelectionCollectionStyle.white
        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .left(inset: 10),
            verticalAlignment: .top(inset: 10)
        )
        return menu
    }
}
