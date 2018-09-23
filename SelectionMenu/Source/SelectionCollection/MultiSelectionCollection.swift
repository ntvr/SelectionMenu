//
//  MultiSelectionCollection.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MultiSelectionCollection
public class MultiSelectionCollection: UIControl, SelectionCollection {
    // Public properties
    public weak var delegate: SelectionCollectionDelegate?

    public var sectionType: SelectionMenu.SectionType

    public var elementStyle: SelectionElementStyling = NoStyle() {
        didSet { updateTheme() }
    }

    /// Currently selected indexes. Use `setSelected(indexes:)` to change them.
    public private(set) var selectedIndexes: [Int]

    // Subviews
    /// Background view which can be used for corner radius to not not mess up shadows.
    public private(set) var backgroundView: UIView!

    /// Contained elements.
    public private(set) var elements: [SelectionElementView]

    /// Initializes SingleSelectionCollection
    ///
    /// - Parameter elements: Elements that should be contained in MultiSelectionCollection.
    public required init(sectionType: SelectionMenu.SectionType, elements: [SelectionElementView]) {
        self.sectionType = sectionType
        self.elements = elements

        if case let .multiSelection(selected) = sectionType {
            selectedIndexes = selected
        } else {
            fatalError("\(#file): Unsupported section type")
        }

        super.init(frame: .zero)

        initSubviews(with: elements)
        setupConstrains()
        setSelected(indexes: selectedIndexes)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension MultiSelectionCollection {
    public func expand(animated: Bool, withDuration animationDuration: TimeInterval) {
        elements.forEach { $0.expand(animated: animated, withDuration: animationDuration) }
    }

    public func collapse(animated: Bool, withDuration animationDuration: TimeInterval) {
        elements.forEach { $0.collapse(animated: animated, withDuration: animationDuration) }
    }
}

// MARK: - Stylable
extension MultiSelectionCollection {
    public var foregroundColorStylable: UIColor? {
        get { return nil }
        set { return }
    }

    public var backgroundColorStylable: UIColor? {
        get { return backgroundView.backgroundColor }
        set { backgroundView.backgroundColor = newValue }
    }

    public var circularStylable: Bool {
        get { return backgroundView.circular }
        set { backgroundView.circular = newValue }
    }

    public var shadowedLayerStylable: CALayer? {
        return layer
    }
}


// MARK: - External API
public extension MultiSelectionCollection {
    func setSelected(indexes: [Int]) {
        let filtered = indexes
            .filter { 0..<elements.count ~= $0 }
        self.selectedIndexes = Array(Set(filtered))

        updateTheme()
    }
}

// MARK: - Tracking touches
extension MultiSelectionCollection {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let hitViews = elements.enumerated().filter { _, element -> Bool in
            let location = touch.location(in: element)
            return element.point(inside: location, with: event)
        }
        guard let hitView = hitViews.first else {
            return // Nothing was hit
        }

        if let index = selectedIndexes.index(of: hitView.offset) {
            elementStyle.apply(to: hitView.element, in: sectionType, selected: false)
            selectedIndexes.remove(at: index)
        } else {
            elementStyle.apply(to: hitView.element, in: sectionType, selected: true)
            selectedIndexes.append(hitView.offset)
        }

        let selectedElements = elements.enumerated()
            .filter { selectedIndexes.contains($0.offset) }
            .map { $1 }

        delegate?.multiSelectionCollection(self, changedSelectionTo: selectedElements, at: selectedIndexes)
    }
}

// MARK - Setup + Theme
private extension MultiSelectionCollection {
    func initSubviews(with elements: [SelectionElementView]) {
        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        elements.forEach { element in
            addSubview(element)
        }
    }

    func updateTheme() {
        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, in: sectionType, selected: selectedIndexes.contains(offset))
        }
    }

    func setupConstrains() {
        var leftEdge = snp.left
        elements.forEach { element in
            element.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(element.snp.height)
                make.left.equalTo(leftEdge)

                leftEdge = element.snp.right
            }
        }
        elements.last?.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }

        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
