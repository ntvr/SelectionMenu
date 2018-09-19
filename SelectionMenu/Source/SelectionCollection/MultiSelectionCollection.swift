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

    public var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    /// Currently selected indexes. Use `setSelected(indexes:)` to change them.
    public private(set) var selectedIndexes: [Int] = []

    // Subviews
    /// Background view which can be used for corner radius to not not mess up shadows.
    public private(set) var backgroundView: UIView!

    /// Contained elements.
    public private(set) var elements: [SelectionElementView]

    /// Initializes SingleSelectionCollection
    ///
    /// - Parameter elements: Elements that should be contained in MultiSelectionCollection.
    public required init(elements: [SelectionElementView]) {
        self.elements = elements
        super.init(frame: .zero)

        initSubviews(with: elements)
        setupConstrains()
        updateTheme()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension MultiSelectionCollection {
    public func expand() {
        elements.forEach { $0.expand() }
    }

    public func collapse() {
        elements.forEach { $0.collapse() }
    }
}

// MARK: - External API
public extension MultiSelectionCollection {
    func setSelected(indexes: [Int]) {
        elements.enumerated()
            .forEach { (offset, element) in
            elementStyle.apply(to: element, selected: indexes.contains(offset))
        }

        let filtered = indexes
            .filter { 0..<elements.count ~= $0 }
        self.selectedIndexes = Array(Set(filtered))
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
            elementStyle.apply(to: hitView.element, selected: false)
            selectedIndexes.remove(at: index)
        } else {
            elementStyle.apply(to: hitView.element, selected: true)
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
            elementStyle.apply(to: element, selected: selectedIndexes.contains(offset))
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
