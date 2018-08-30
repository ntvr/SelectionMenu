//
//  MenuViewProtocols.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 10/07/2018.
//  Copyright © 2018 NETVOR s.r.o. All rights reserved.
//

import Foundation
import UIKit

/// SelectionElementView type is only used as an API and property definiton.
///
/// - Important:
/// - This type cannot be subclassed.
/// - Desired way to adapt to this type is to subclass `UIView` and implement `SelectionElement` protocol.
public typealias SelectionElementView = UIView & SelectionElement

/// SelectionCollectionView type is only used as an API and property definiton.
///
/// - Important:
/// - This type cannot be subclassed.
/// - Desired way to adapt to this type is to subclass `UIView` and implement `SelectionCollection` protocol.
public typealias SelectionCollectionView = UIView & SelectionCollection

/// MenuButtonView type is only used as an API and property definiton.
///
/// - Important:
/// - This type cannot be subclassed.
/// - Desired way to adapt to this type is to subclass `UIView` and implement `MenuButton` protocol.
public typealias MenuButtonView = UIView & MenuButton

/// You have to adapt any view to `SelectionElement` protocol if you want them used as elements in SelectionMenu.
public protocol SelectionElement: Expandable { }

/// You have to adapt any view to `SelectionCollection` protocol if you want them used as collections in SelectionMenu.
public protocol SelectionCollection: Expandable {
    /// The object that acts as the delegate of the SelectionCollection.
    /// The delegate must adopt the `SelectionCollectionDelegate` protocol. The delegate is not retained.
    var delegate: SelectionCollectionDelegate? { get set }

    /// Style to be applied to each contained collection.
    var collectionStyle: SelectionCollectionStyling { get set }

    /// Style to be applied to each contained element.
    var elementStyle: SelectionElementStyling { get set }

    /// Contained elements that the collection is responsible for displaying.
    var elements: [SelectionElementView] { get }

    /// `SelectionCollection` has to be initializable with its contained elements.
    init(elements: [SelectionElementView])
}

/// You have to adapt any view to `MenuButton` protocol if you want it used as menu button in `SelectionMenu`.
public protocol MenuButton: Expandable, TapActionRegisterable { }

// MARK: - SelectionCollectionDelegate
/// The delegate of a `SelectionCollection` object must adopt the `SelectionCollectionDelegate` protocol.
///
/// All methods are required and they inform the delegate about user's interaction with the UI.
public protocol SelectionCollectionDelegate: class {
    /// Lets delegate object know about selection of view within single selection collection.
    ///
    /// - Important
    /// Selected index does not have to be unique from previously selected.
    func singleSelectionCollection(_ collection: SingleSelectionCollection,
                                   didSelect element: SelectionElementView,
                                   at index: Int)

    /// Lets delegate object know about selection of views within multi selection collection.
    ///
    /// - Important
    /// Selected indexes do not have to be unique from previously selected.
    func multiSelectionCollection(_ collection: MultiSelectionCollection,
                                  changedSelectionTo elements: [SelectionElementView],
                                  at indexes: [Int])

    /// Lets delegate object know about pressing tapping view within button selection collection.
    func buttonSelectionCollection(_ collection: ButtonSelectionCollection,
                                   didTapIndex index: Int)
}

// MARK: - Expandable
/// Defines api of the objects that can transition their layout from expanded to collapsed and the other way.
@objc public protocol Expandable {
    /// Sets up the expanded layout of the object. This is expected to be done through manipulating its bounds.
    ///
    /// In case of internal views following is used:
    /// ```
    /// @objc func expand() {
    ///     setupExpandedConstraints()
    ///     setNeedsLayout()
    ///     layoutIfNeeded()
    /// }
    /// ```
    @objc func expand()

    /// Sets up the collapsed layout of the object. This is expected to be done through manipulating its bounds.
    ///
    /// In case of internal views following is used:
    /// ```
    /// @objc func collapse() {
    ///     setupCollapsedConstraints()
    ///     setNeedsLayout()
    ///     layoutIfNeeded()
    /// }
    /// ```
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
