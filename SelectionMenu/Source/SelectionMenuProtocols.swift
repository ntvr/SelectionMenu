//
//  MenuViewProtocols.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 10/07/2018.
//  Copyright © 2018 NETVOR s.r.o. All rights reserved.
//

import Foundation
import UIKit

public typealias SelectionElementView = UIView & SelectionElement
public typealias SelectionCollectionView = UIView & SelectionCollection
public typealias MenuButtonView = UIView & MenuButton

public protocol SelectionElement: Expandable { }
public protocol SelectionCollection: Expandable {
    var delegate: SelectionCollectionDelegate? { get set }

    var collectionStyle: SelectionCollectionStyling { get set }
    var elementStyle: SelectionElementStyling { get set }
    var elements: [SelectionElementView] { get }

    init(elements: [SelectionElementView])
}
public protocol MenuButton: Expandable, TapActionRegisterable { }

// MARK: - SelectionCollectionDelegate
public protocol SelectionCollectionDelegate: class {
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
@objc public protocol Expandable {
    @objc func expand()
    @objc func collapse()
}

// MARK: - SelectionElementStyling
public protocol SelectionElementStyling {
    func apply(to element: SelectionElementView, selected: Bool)
}

// MARK: - SelectionCollectionStyling
public protocol SelectionCollectionStyling {
    func apply(to collection: SelectionCollectionView)
}

// MARK: - ActionRegistrable
@objc public protocol TapActionRegisterable {
    var tapEnabled: Bool { get set }
    func addTargetForTapGesture(target: Any?, action: Selector)
}
