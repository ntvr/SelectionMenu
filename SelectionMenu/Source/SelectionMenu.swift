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
    /// Visual effect to be shown in the background when the SelectionMenu is presented.
    var visualEffect: UIVisualEffect? { get }

    /// Number of `SelectionCollection`s in `SelectionMenu`.
    func selectionMenuNumberOfSections() -> Int

    /// Type of the `SelectionCollection` determines which UI component will be used for the collection.
    func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType

    /// Number of `SelectionElement`s within `SelectionColletion` in given section.
    func selectionMenu(numberOfElementsIn section: Int) -> Int

    /// `SelectionElementView` which should be used for given index in given section.
    /// All views from single section will be gathered at once before initialization of their containing collection.
    func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView
}

// MARK: - SelectionMenuButton
public class SelectionMenu: UIView {

    /// Type of the section determines which kind of UI will be used for section.
    public enum SectionType: Hashable {
        /// Single selection collection with default selected index.
        case singleSelection(selected: Int)

        /// Multi selection collection with default selected indexes given in an array.
        case multiSelection(selected: [Int])

        /// Button selection collection.
        case buttonSelection

        public var hashValue: Int {
            switch self {
            case .singleSelection: return 1
            case .multiSelection:  return 2
            case .buttonSelection: return 3
            }
        }
    }

    /// The object that acts as the delegate of the selection menu.
    /// The delegate must adopt the SelectionMenuDelegate protocol. The delegate is not retained.
    public weak var delegate: SelectionMenuDelegate?

    /// The object that acts as the data source of the selection menu.
    /// The data sources must adopt the SelectionMenuDataSource protocol. The data source is not retained.
    /// - Important:
    /// Data source is only taken in consideration when the menu is being shown to construct the view structure.
    /// It has no meaning afterwards until `show(animated:)` is called next time.
    public weak var dataSource: SelectionMenuDataSource?

    /// Controls whether the menu content should be hidden when platform/visualEffect is tapped.
    /// This property is checked each time platform is tapped. Defaults to true.
    public var hideViewOnTappingPlatform: Bool = true

    /// Controls show/hide animation duration. Defaults to 0.5.
    public var animationDuration: TimeInterval = 0.5

    /// The object that acts as the layout of the selection menu's collections.
    /// The layout must adopt the SelectionMenuLayouting protocol. The layout is retained.
    /// Defaults to `AutomaticMenuLayout`
    public var collectionsLayout: SelectionMenuLayouting = AutomaticMenuLayout()

    /// Style to be applied to each contained collection.
    public var collectionStyle: SelectionCollectionStyling = UniversalStyle.redWhite {
        didSet { updateTheme() }
    }

    /// Style to be applied to each contained element.
    public var elementStyle: SelectionElementStyling = UniversalStyle.redWhite {
        didSet { updateTheme() }
    }

    // MARK: -  Private properties
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
public extension SelectionMenu {
    /// Registers given class as a collection type for given section.
    /// Given type must subclass `UIView` and adopt SelectionCollection protocol.
    ///
    /// Defaults to:
    /// - `SingleSelectionCollection` for `SectionType.singleSelection`
    /// - `MultiSelectionCollection` for `SectionType.multiSelection`
    /// - `ButtonSelectionCollection` for `SectionType.buttonSelection`
    func register(collectionType: SelectionCollectionView.Type, for sectionType: SectionType) {
        collectionTypeMap[sectionType] = collectionType
    }

    /// - Inserts the platform (UIView) beneath itself and populates it with content.
    /// - Sets the layout to hidden and starts animation to shown layout.
    ///
    /// This method is triggered when associated menu button is tapped. Can be called manually.
    func show(animated: Bool) {
        // TODO: Check if the menu is not already being presented
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

    /// - Animates all subviews to hidden layout.
    /// - Removes the platform with all its contained views.
    /// - Cleans up associated properties for example `elementViews`.
    ///
    /// This method is triggered when associated menu button is tapped. Can be called manually.
    func hide(animated: Bool) {
        // TODO: - Check if the menu is not already being hidden
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
            collectionStyle.apply(to: collection)
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
