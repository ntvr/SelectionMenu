//
//  MenuViewProtocols.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 10/07/2018.
//  Copyright © 2018 NETVOR s.r.o. All rights reserved.
//

import Foundation
import UIKit

typealias SelectionElementView = UIView & SelectionElement
typealias SelectionCollectionView = UIView & SelectionCollection
typealias MenuButtonView = UIView & MenuButton

protocol SelectionElement: Expandable { }
protocol SelectionCollection: Expandable {
    var delegate: SelectionCollectionDelegate? { get set }

    var collectionStyle: SelectionCollectionStyling { get set }
    var elementStyle: SelectionElementStyling { get set }

    init(elements: [SelectionElementView])
}
protocol MenuButton: Expandable, TapActionRegisterable { }

// MARK: - SelectionCollectionDelegate
protocol SelectionCollectionDelegate: class {
    func singleSelectionCollection(_ collection: SingleSelectionCollection,
                                   didSelect element: SelectionElementView,
                                   at index: Int)
    func multiSelectionCollection(_ collection: MultiSelectionCollection,
                                  changedSelectionTo elements: [SelectionElementView],
                                  at indexes: [Int])
    func buttonSelectionCollection(_ collection: ButtonSelectionCollection,
                                   didTapIndex index: Int)
}

// MARK: - Expandable
@objc protocol Expandable {
    @objc func expand()
    @objc func collapse()
}

// MARK: - SelectionElementStyling
protocol SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool)
}

// MARK: - SelectionCollectionStyling
protocol SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView)
}

// MARK: - ActionRegistrable
@objc protocol TapActionRegisterable {
    var tapEnabled: Bool { get set }
    func addTargetForTapGesture(target: Any?, action: Selector)
}
