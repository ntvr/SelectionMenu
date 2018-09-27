//
//  PredefinedStyles.swift
//  Pods-SelectionMenu_Example
//
//  Created by Michal Štembera on 20/09/2018.
//

import Foundation

// MARK: - SelectionElementStyle - Predefined styles
public extension SelectionElementStyle {
    public static var red: SelectionElementStyle {
        return SelectionElementStyle(contentColor: .white, baseColor: .red)
    }

    public static var green: SelectionElementStyle {
        return SelectionElementStyle(contentColor: .black, baseColor: .green)
    }

    public static var blue: SelectionElementStyle {
        return SelectionElementStyle(contentColor: .white, baseColor: .blue)
    }

    public static var white: SelectionElementStyle {
        return SelectionElementStyle(circular: true,
                                     selectedFgColor: .black,
                                     selectedBgColor: .lightGray,
                                     deselectedFgColor: .gray,
                                     deselectedBgColor: .white)
    }

    public static var black: SelectionElementStyle {
        return SelectionElementStyle(contentColor: .white, baseColor: .black)
    }
}

// MARK: - SelectionElementStyle - Predefined styles
public extension SelectionCollectionStyle {
    public static var red: SelectionCollectionStyle {
        return SelectionCollectionStyle(baseColor: .red)
    }

    public static var green: SelectionCollectionStyle {
        return SelectionCollectionStyle(baseColor: .green)
    }

    public static var blue: SelectionCollectionStyle {
        return SelectionCollectionStyle(baseColor: .blue)
    }

    public static var white: SelectionCollectionStyle {
        return SelectionCollectionStyle(circular: true,
                                        foregroundColor: .lightGray,
                                        backgroundColor: .white)
    }

    public static var black: SelectionCollectionStyle {
        return SelectionCollectionStyle(baseColor: .black)
    }
}
