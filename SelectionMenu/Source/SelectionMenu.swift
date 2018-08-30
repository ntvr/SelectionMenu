//
//  MenuView.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 09/07/2018.
//  Copyright © 2018 NETVOR s.r.o. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: SelectionMenuDelegate
public protocol SelectionMenuDelegate: class {
    /// Called whenever `SelectionMenu`'s `show(animated:)` is intitiated.
    func selectionMenu(_ menu: SelectionMenu, willShow animated: Bool)
    /// Called whenever `SelectionMenu`'s `hide(animated:)` is intitiated.
    func selectionMenu(_ menu: SelectionMenu, willHide animated: Bool)

    /// Called whenever contained collection of type `.singleSelection` selects element.
    /// The same element can be selected multiple times in a row.
    func selectionMenu(_ menu: SelectionMenu, didSelectSingleIndex index: Int, in section: Int)
    /// Called whenever contained collection of type `.multiSelection` changes its selection.
    /// Set of the indexes is not ordered and does not have to change between calls.
    func selectionMenu(_ menu: SelectionMenu, didSelectMultipleIndexes indexes: [Int], in section: Int)
    /// Called whenever contained collection of type `.buttonSelection` presses (.touchUpInside)  button.
    func selectionMenu(_ menu: SelectionMenu, didSelectButtonAt index: Int, in section: Int)
}

// MARK: - SelectionMenuDataSource
public protocol SelectionMenuDataSource: class {
    var visualEffect: UIVisualEffect? { get }
    func selectionMenuNumberOfSections() -> Int
    func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType
    func selectionMenu(numberOfElementsIn section: Int) -> Int
    func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView
}

// MARK: - SelectionMenuButton
public class SelectionMenu: UIView {
    public enum SectionType: Hashable {
        case singleSelection(selected: Int)
        case multiSelection(selected: [Int])
        case buttonSelection

        public var hashValue: Int {
            switch self {
            case .singleSelection: return 1
            case .multiSelection:  return 2
            case .buttonSelection: return 3
            }
        }
    }

    public weak var delegate: SelectionMenuDelegate?
    public weak var dataSource: SelectionMenuDataSource?

    // Functionality
    public var hideViewOnTappingPlatform: Bool = true
    public var animationDuration: TimeInterval = 0.5
    // Layout
    public var collectionsLayout: SelectionMenuLayouting = AutomaticMenuLayout()
    // Styles
    public var collectionStyle: SelectionCollectionStyling = UniversalStyle.redWhite { didSet { updateTheme() } }
    public var elementStyle: SelectionElementStyling = UniversalStyle.redWhite { didSet { updateTheme() } }

    // Private properties
    private static var defaultDataSource: SelectionMenuDataSource = EmptyDataSource()

    private weak var menuButton: MenuButtonView!
    private weak var platform: UIView?
    private weak var backgroundBlurView: UIVisualEffectView?
    private var collections: [SelectionCollectionView]?
    private weak var platformGetureRecongizer: UITapGestureRecognizer?

    private var collectionTypeMap: [SectionType: SelectionCollectionView.Type] = [:]

    public init(menuButton: MenuButtonView) {
        super.init(frame: .zero)

        addSubview(menuButton)
        self.menuButton = menuButton

        menuButton.addTargetForTapGesture(target: self, action: #selector(didTapMenuButton))

        setupConstraints()
        updateTheme()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public API
public extension SelectionMenu{
    func register(collectionType: SelectionCollectionView.Type, for sectionType: SectionType) {
        collectionTypeMap[sectionType] = collectionType
    }

    func show(animated: Bool) {
        delegate?.selectionMenu(self, willShow: animated)

        let dataSource = self.dataSource ?? SelectionMenu.defaultDataSource
        loadViews(from: dataSource)

        // Prepare hidden layout
        setupHideConstraints()
        platform?.setNeedsLayout()
        platform?.layoutIfNeeded()
        platform?.alpha = 0
        backgroundBlurView?.effect = nil
        collections?.forEach { $0.collapse() }

        let showClosure: () -> Void = {
            self.setupShowConstraints()
            self.platform?.setNeedsLayout()
            self.platform?.layoutIfNeeded()
            self.platform?.alpha = 1
            self.backgroundBlurView?.effect = dataSource.visualEffect
            self.collections?.forEach { $0.expand() }
        }

        if animated {
            UIView.animate(withDuration: animationDuration,
                           animations: showClosure)
        } else {
            showClosure()
        }
    }

    func hide(animated: Bool) {
        delegate?.selectionMenu(self, willHide: animated)

        let hideClosure: () -> Void = {
            self.setupHideConstraints()
            self.platform?.setNeedsLayout()
            self.platform?.layoutIfNeeded()
            self.platform?.alpha = 0
            self.backgroundBlurView?.effect = nil
            self.menuButton.tapEnabled = false
            self.platformGetureRecongizer?.isEnabled = false
            self.collections?.forEach { $0.collapse() }
        }

        let completionClosure: (Bool) -> Void = { completed in
            self.menuButton.tapEnabled = true
            self.platform?.removeFromSuperview()
            self.backgroundBlurView?.removeFromSuperview()
            self.collections = nil
        }

        if animated {
            UIView.animate(withDuration: animationDuration,
                           animations: hideClosure,
                           completion: completionClosure)
        } else {
            hideClosure()
            completionClosure(true)
        }
    }
}

// MARK: - SelectionCollectionDelegate
extension SelectionMenu: SelectionCollectionDelegate {
    public func singleSelectionCollection(_ collection: SingleSelectionCollection,
                                   didSelect element: SelectionElementView,
                                   at index: Int) {
        let collections = self.collections as [UIView]?
        guard let section = collections?.index(of: collection) else {
            return
        }

        delegate?.selectionMenu(self, didSelectSingleIndex: index, in: section)
    }

    public func multiSelectionCollection(_ collection: MultiSelectionCollection,
                                  changedSelectionTo elements: [SelectionElementView],
                                  at indexes: [Int]) {
        let collections = self.collections as [UIView]?
        guard let section = collections?.index(of: collection) else {
            return
        }

        delegate?.selectionMenu(self, didSelectMultipleIndexes: indexes, in: section)
    }

    public func buttonSelectionCollection(_ collection: ButtonSelectionCollection, didTapIndex index: Int) {
        let collections = self.collections as [UIView]?
        guard let section = collections?.index(of: collection) else {
            return
        }

        delegate?.selectionMenu(self, didSelectButtonAt: index, in: section)
    }
}


// MARK: - User interaction
extension SelectionMenu: UIGestureRecognizerDelegate {
    @objc func didTapMenuButton() {
        if platform == nil {
            show(animated: true)
        } else {
            hide(animated: true)
        }
    }

    @objc func didTapPlatform(gestureRecognizer: UITapGestureRecognizer) {
        if platform != nil && hideViewOnTappingPlatform {
            hide(animated: true)
        }
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view != nil && [platform, backgroundBlurView].contains(touch.view)
    }
}

// MARK: - Private working methods
private extension SelectionMenu {
    func setupConstraints() {
        menuButton?.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateTheme() {
        collections?.forEach { collection  in
            collection.collectionStyle = collectionStyle
            collection.elementStyle = elementStyle
        }
    }

    func prepareCollection(for sectionType: SectionType,
                           with elements: [SelectionElementView]) -> SelectionCollectionView {
        var collectionType: SelectionCollectionView.Type! = collectionTypeMap[sectionType]

        switch sectionType {
        case .singleSelection: collectionType = SingleSelectionCollection.self
        case .multiSelection: collectionType = MultiSelectionCollection.self
        case .buttonSelection: collectionType = ButtonSelectionCollection.self
        }

        return (collectionType as SelectionCollection.Type)
            // TODO: How to solve that without force cast
            // swiftlint:disable:next force_cast
            .init(elements: elements) as! SelectionCollectionView
    }

    func loadViews(from dataSource: SelectionMenuDataSource) {
        let sectionsCount = dataSource.selectionMenuNumberOfSections()
        let views: [(SectionType, [SelectionElementView])] =
            (0..<sectionsCount)
            .map { section in (section, dataSource.selectionMenu(numberOfElementsIn: section))}
            .map { section, buttonsCount in
                let sectionType = dataSource.selectionMenu(typeOf: section)
                let views = (0..<buttonsCount).map { index in
                    dataSource.selectionMenu(viewFor: index, in: section)
                }
                return (sectionType, views)
        }

        let platform = UIView()
        let collections: [SelectionCollectionView] = views.map { type, views in
            let collection = prepareCollection(for: type, with: views)
            collection.delegate = self
            return collection
        }
        let blurView = UIVisualEffectView(effect: nil)

        collections.forEach(platform.addSubview)
        superview?.insertSubview(blurView, belowSubview: self)
        superview?.insertSubview(platform, belowSubview: self)

        self.collections = collections
        self.backgroundBlurView = blurView
        self.platform = platform

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(didTapPlatform(gestureRecognizer:)))
        platform.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self
        platformGetureRecongizer = tapGestureRecognizer

        updateTheme()
    }

    func setupShowConstraints() {
        platform?.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundBlurView?.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        if let platform = platform, let collections = collections {
            collectionsLayout.layoutCollections(menu: self, platform: platform, collections: collections)
        }
    }


    func setupHideConstraints() {
        platform?.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundBlurView?.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }

        collections?.forEach { view in
            view.snp.remakeConstraints { make in
                make.center.equalTo(self)
                make.height.equalTo(0)
            }
        }
    }
}
