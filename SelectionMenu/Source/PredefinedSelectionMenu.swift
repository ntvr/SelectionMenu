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

    /// Predefined SelectionMenu based on **Chocolaty Browns** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Outdoorsy & Natural** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Fresh & Energetic** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Day & Night** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Crisp Complementary** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Bold & Basic** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
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

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Orange Accent** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
    public static var orangeAccent: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white,
                                              bg: OrangeAccent.orange)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .white,
                                                  selectedBgColor: OrangeAccent.orange,
                                                  deselectedFgColor: OrangeAccent.sandDollar,
                                                  deselectedBgColor: OrangeAccent.woodVeener)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: OrangeAccent.orange,
                                                        backgroundColor: OrangeAccent.charcoal)

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Sunny Citrus** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
    public static var sunnyCitrus: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white,
                                              bg: SunnyCitrus.rubyRed)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .black,
                                                  selectedBgColor: SunnyCitrus.citrus,
                                                  deselectedFgColor: .white,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: SunnyCitrus.citrus,
                                                        backgroundColor: SunnyCitrus.grapefruit)

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Fresh Greens** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
    public static var freshGreens: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: FreshGreens.cotton,
                                              bg: FreshGreens.emerald)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .black,
                                                  selectedBgColor: FreshGreens.lightGreen,
                                                  deselectedFgColor: FreshGreens.cotton,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: FreshGreens.lightGreen,
                                                        backgroundColor: FreshGreens.greenBean)

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }

    /// Predefined SelectionMenu based on **Chocolaty Browns** color combination from
    /// [100 brilliant color combinations](https://www.canva.com/learn/100-color-combinations/)
    ///
    /// Setups all of following (can be overriden from the outside if necessary)
    /// - SelectionMenuButton and adds it as subview
    /// - SelectionElementStyle
    /// - SelectionCollectionStyle
    /// - SelectionMenuLayouting which defaults to AutomaticMenuLayout()
    public static var chocolatyBrowns: SelectionMenu {
        let button = SelectionMenu.menuButton(fg: .white,
                                              bg: ChocolatyBrowns.cocoa)
        let menu = SelectionMenu(menuButton: button)

        menu.elementStyle = SelectionElementStyle(circular: true,
                                                  selectedFgColor: .white,
                                                  selectedBgColor: ChocolatyBrowns.toffee,
                                                  deselectedFgColor: .white,
                                                  deselectedBgColor: .clear)

        menu.collectionStyle = SelectionCollectionStyle(circular: true,
                                                        foregroundColor: ChocolatyBrowns.toffee,
                                                        backgroundColor: ChocolatyBrowns.chocolate)

        menu.collectionsLayout = AutomaticMenuLayout()

        return menu
    }
}
