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

    public static var outdoorsyAndNatural: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white, bg: OutdoorsyAndNatural.forestGreen)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: OutdoorsyAndNatural.earth,
                                                  selectedBgColor: OutdoorsyAndNatural.lime,
                                                  deselectedFgColor: .white,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: OutdoorsyAndNatural.lime,
                                                        backgroundColor: OutdoorsyAndNatural.forestGreen)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }

    public static var freshAndEnergetic: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: FreshAndEnergetic.granite, bg: FreshAndEnergetic.pine)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .black,
                                                  selectedBgColor: FreshAndEnergetic.blueSky,
                                                  deselectedFgColor: .black,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: FreshAndEnergetic.blueSky,
                                                        backgroundColor: FreshAndEnergetic.fields)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }

    public static var dayAndNight: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: DayAndNight.blueberry, bg: DayAndNight.tangerine)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: DayAndNight.darkNavy,
                                                  selectedBgColor: DayAndNight.tangerine,
                                                  deselectedFgColor: DayAndNight.daffodil,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: DayAndNight.tangerine,
                                                        backgroundColor: DayAndNight.blueberry)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }

    public static var crispComplementary: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: CrispComplementary.goldenDelicious,
                                              bg: CrispComplementary.ripeApple)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: CrispComplementary.goldenDelicious,
                                                  selectedBgColor: CrispComplementary.ripeApple,
                                                  deselectedFgColor: CrispComplementary.grannySmith,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: CrispComplementary.ripeApple,
                                                        backgroundColor: CrispComplementary.redDelicious)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }

    public static var boldAndBasic: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: BoldAndBasic.flash,
                                              bg: BoldAndBasic.phoneBoothRed)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: BoldAndBasic.flash,
                                                  selectedBgColor: BoldAndBasic.phoneBoothRed,
                                                  deselectedFgColor: BoldAndBasic.pearl,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: BoldAndBasic.phoneBoothRed,
                                                        backgroundColor: BoldAndBasic.night)

        menu.collectionsLayout = ManualMenuLayout(
            horizontalAlignment: .rightToRight,
            verticalAlignment: .topToBottom(direction: .up)
        )

        return menu
    }
}
