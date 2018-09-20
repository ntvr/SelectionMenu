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
public protocol SelectionElement: Expandable, Stylable { }

/// You have to adapt any view to `SelectionCollection` protocol if you want them used as collections in SelectionMenu.
public protocol SelectionCollection: Expandable, Stylable {
    /// The object that acts as the delegate of the SelectionCollection.
    /// The delegate must adopt the `SelectionCollectionDelegate` protocol. The delegate is not retained.
    var delegate: SelectionCollectionDelegate? { get set }

    /// Stores the initial type of section the collection is contained within
    /// Also sets the initially selected index/indexes
    var sectionType: SelectionMenu.SectionType { get }

    /// Style to be applied to each contained element.
    var elementStyle: SelectionElementStyling { get set }

    /// Contained elements that the collection is responsible for displaying.
    var elements: [SelectionElementView] { get }

    /// `SelectionCollection` has to be initializable with its contained elements.
    init(sectionType: SelectionMenu.SectionType, elements: [SelectionElementView])
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
    /// @objc func expand(animated: Bool) {
    ///     setupExpandedConstraints()
    ///     setNeedsLayout()
    ///     layoutIfNeeded()
    /// }
    /// ```
    ///
    /// - Parameter animated: Controls whether the expansion should be animated.
    /// In case of constraints changes this will be handled externaly by SelectionMenu.
    @objc func expand(animated: Bool)

    /// Sets up the collapsed layout of the object. This is expected to be done through manipulating its bounds.
    ///
    /// In case of internal views following is used:
    /// ```
    /// @objc func collapse(animated: Bool) {
    ///     setupCollapsedConstraints()
    ///     setNeedsLayout()
    ///     layoutIfNeeded()
    /// }
    /// ```
    ///
    /// - Parameter animated: Controls whether the expansion should be animated.
    /// In case of constraints changes this will be handled externaly by SelectionMenu.
    @objc func collapse(animated: Bool)
}

// MARK: - ActionRegistrable
/// Unifies the api for views to be registered for tap recognition.
@objc public protocol TapActionRegisterable {
    /// Controls whether the tap gesture is enabled for the view or not.
    var tapEnabled: Bool { get set }

    /// Registers the tap gesture for the view. The implementation is up to the view.
    ///
    /// For example UIButton just calls `addTarget(_, action:, for:)` for .touchUpInside.
    func addTargetForTapGesture(target: Any?, action: Selector)
}
